# libmuffintop

libmuffintop is a handwritten LLVM IR runtime for low-level, cross-platform
kernel primitives. It exposes a fixed-width target ABI rather than the C POSIX
ABI and has no libc dependency.

The current source tree contains shared runtime code, Linux x86-64 and AArch64
host layers, a macOS ARM64 host layer, and Linux process entry shims.

The project is licensed under the MIT license in `LICENSE`.
