# libmuffintop

libmuffintop is a handwritten LLVM IR runtime for programs that need direct,
cross-platform kernel primitives without libc. It provides one fixed-width
target ABI and translates that ABI inside architecture-specific host layers.

Its public names are POSIX-derived vocabulary, but libmuffintop is not libc and
does not implement the C POSIX ABI. Call signatures, record layouts, constants,
and errors belong to libmuffintop. Target-aligned operations return negative
target errno values directly instead of setting a global `errno`.

## Runtime model

The shared module exposes primitives for file descriptors and filesystems,
process and identity operations, signals and waiting, virtual memory, clocks
and sleeping, directory access, and terminal control. Host interaction stays
inside the selected host layer.

| Target | Host implementation | Entry shim |
| --- | --- | --- |
| Linux x86-64 | Direct Linux syscalls | Included |
| Linux AArch64 | Direct Linux syscalls | Included |
| macOS ARM64 | Direct Darwin syscalls and Mach traps | Supplied by the consumer |

The source imports no libc, dynamic-loader, or pthread symbols and has no global
errno. A small set of compiler support primitives required by emitted LLVM code
is implemented inside `src/libmuffintop.ll`.

## Source layout

| Path | Role |
| --- | --- |
| `src/libmuffintop.ll` | Public target ABI, target constants, common validation, and shared operations |
| `src/host/linux_common.ll` | Linux behavior shared by both supported architectures |
| `src/host/linux_x86_64.ll` | Linux x86-64 syscall numbers, layouts, and translations |
| `src/host/linux_aarch64.ll` | Linux AArch64 syscall numbers, layouts, and translations |
| `src/host/macos_arm64.ll` | macOS ARM64 Darwin and Mach host implementation |
| `src/start/linux_x86_64.ll` | Linux x86-64 `_start` shim |
| `src/start/linux_aarch64.ll` | Linux AArch64 `_start` shim |

Every program includes the shared module. Linux programs also include
`linux_common.ll` and one architecture host layer. macOS ARM64 programs include
the shared module and `macos_arm64.ll`. Add a start shim when libmuffintop
should provide the process entry point.

## Ubuntu packages

On Ubuntu 24.04 LTS and 26.04 LTS, install the tools used by the Linux build
example with:

```sh
sudo apt update
sudo apt install --yes ca-certificates git llvm binutils
```

The commands come from these Ubuntu packages:

| Commands or facility | Ubuntu package |
| --- | --- |
| `git` | `git` |
| HTTPS certificate store used by `git clone` | `ca-certificates` |
| `llvm-as`, `llvm-link`, `opt`, `llc` | `llvm` |
| `ld`, `nm`, `readelf` | `binutils` |

Clone the source before following the link example:

```sh
git clone https://github.com/nialse/libmuffintop.git
cd libmuffintop
```

## Link into a Linux x86-64 program

The application is another LLVM module. When using the bundled start shim it
must define this entry function:

```llvm
declare void @_exit(i32)

define void @__poc_program_start(i64 %argc, ptr %argv) {
entry:
  call void @_exit(i32 0)
  unreachable
}
```

Assemble and link the modules with LLVM tools:

```sh
llvm-as app.ll -o app.bc
llvm-as src/libmuffintop.ll -o libmuffintop.bc
llvm-as src/host/linux_common.ll -o linux_common.bc
llvm-as src/host/linux_x86_64.ll -o linux_x86_64.bc
llvm-as src/start/linux_x86_64.ll -o start.bc

llvm-link app.bc libmuffintop.bc linux_common.bc linux_x86_64.bc start.bc \
  -o linked.bc
opt -passes=verify linked.bc -o program.bc
llc -filetype=obj -relocation-model=static program.bc -o program.o
ld -static -e _start program.o -o program
```

Consumers with their own entry code can omit `src/start/linux_x86_64.ll`. The
same composition applies to Linux AArch64 with the matching host and start
modules. A consumer targeting macOS ARM64 supplies its platform entry and
linkage.

The verification-only pipeline above preserves the repository-owned memory and
string loops and produces a static executable with no undefined symbols. More
aggressive LLVM optimization can recognize those loops and synthesize calls
such as `memset` or `strlen`. An optimized consumer must provide any such
lowered helpers, as JEQY does, or use a pipeline that keeps the loops internal.

## Design boundaries

Public code calls the functions defined by `src/libmuffintop.ll`; it does not
call private `__mtrt_host_*` symbols. Host layers translate target flags,
signals, clocks, structures, and error values to their native kernel forms.

The repository contains the runtime source history, a short project
description, and the MIT license.

## License

libmuffintop is licensed under the MIT license in [`LICENSE`](LICENSE).
