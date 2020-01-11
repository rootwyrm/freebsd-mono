# freebsd-mono
This repository contains my working versions of the mono ports for FreeBSD, in portshaker and CI friendly layout.

You can check the official Mono project CI status here:
https://jenkins.mono-project.com/job/test-mono-mainline-community/label=freebsd-12-amd64/

Most are fully tested including full Mono test suite. Some are... not. 

# Versions Covered
- lang/mono5.14 - **EXPERIMENTAL** 
  - ONLY_FOR: i386, amd64
  - Does NOT build consistent, which may break .NET applications
  - Has exhibited certificate errors, which may break .NET applications
  - inotify shim disabled; breaks many .NET applications
- lang/mono5.16 - **INCOMPLETE** 
  - ONLY_FOR: i386, amd64
  - Building successfully
  - inotify shim not yet fixed; breaks many .NET applications
- lang/mono5.18 - **MOSTLY COMPLETE** 
  - ONLY_FOR: i386, amd64, powerpc64 (EXPERIMENTAL)
  - Building successfully, passes Mono tests
  - inotify shim not yet fixed; breaks many .NET applications
  - SQLite dependency not yet implemented
  - Tests NOT functioning fully due to missing shebangfixes and known issues on FreeBSD
- lang/mono5.20 - **MOSTLY COMPLETE** 
  - ONLY_FOR: i386, amd64, aarch64 (EXPERIMENTAL), powerpc64 (EXPERIMENTAL)
  - Building successfully (native)
  - Building partially successfully (qemu)
  - **DANGER!** QEMU BUILDS NOT RECOMMENDED: MAY HANG OR GENERATE BROKEN BINARIES
  - **corefx**: inotify shim fix in progress, cannot be submitted upstream
  - SQLite dependency not yet implemented
  - unixODBC not yet implemented
- lang/mono6.0 - **COMPLETE**
  - [Mono Project CI Unit Testing Here](https://jenkins.mono-project.com/job/test-mono-mainline-community/label=freebsd-12-amd64/)
  - ONLY_FOR: i386, amd64
  - **DANGER!** QEMU BUILDS WILL FAIL
  - Building successfully (native)
  - Failing to build (qemu - known qemu defect)
  - **corefx**: [patch for inotify shim submitted upstream](https://github.com/dotnet/corefx/pull/39680)
  - inotify shim implemented and passing unit tests
  - SQLite implemented, unit tests not performed yet
  - unixODBC implemented, unit tests not performed yet
