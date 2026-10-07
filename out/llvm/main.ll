
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx27.0.0"


%Unit = type i1
%Bool = type i1
%Byte = type i8
%Word8 = type i8
%Word16 = type i16
%Word32 = type i32
%Word64 = type i64
%Word128 = type i128
%Word256 = type i256
%Char8 = type i8
%Char16 = type i16
%Char32 = type i32
%Int8 = type i8
%Int16 = type i16
%Int32 = type i32
%Int64 = type i64
%Int128 = type i128
%Int256 = type i256
%Nat8 = type i8
%Nat16 = type i16
%Nat32 = type i32
%Nat64 = type i64
%Nat128 = type i128
%Nat256 = type i256
%Float16 = type half
%Float32 = type float
%Float64 = type double
%Fixed32 = type i32
%Fixed64 = type i64
%Size = type i64
%Pointer = type i8*
%Str8 = type [0 x %Char8]
%Str16 = type [0 x %Char16]
%Str32 = type [0 x %Char32]
%__VA_List = type i8*
declare void @llvm.memcpy.p0.p0.i32(i8*, i8*, i32, i1)
declare void @llvm.memset.p0.i32(i8*, i8, i32, i1)

declare i8* @llvm.stacksave()

declare void @llvm.stackrestore(i8*)


; MODULE: main

; -- print includes --
; from included ctypes64
%Str = type %Str8;
%Char = type %Char8;
%ConstChar = type %Char;
%SignedChar = type %Int8;
%UnsignedChar = type %Nat8;
%Short = type %Int16;
%UnsignedShort = type %Nat16;
%Int = type %Int32;
%UnsignedInt = type %Nat32;
%LongInt = type %Int64;
%UnsignedLongInt = type %Nat64;
%Long = type %Int64;
%UnsignedLong = type %Nat64;
%LongLong = type %Int64;
%UnsignedLongLong = type %Nat64;
%LongLongInt = type %Int64;
%UnsignedLongLongInt = type %Nat64;
%Float = type %Float32;
%Double = type %Float64;
%LongDouble = type %Float64;
%SizeT = type %UnsignedLongInt;
%SSizeT = type %LongInt;
%IntPtrT = type %Nat64;
%PtrDiffT = type %Int64;
%OffT = type %Int64;
%USecondsT = type %Nat32;
%PIDT = type %Int32;
%UIDT = type %Nat32;
%GIDT = type %Nat32;
; from included stdlib
declare void @abort()
declare %Int @abs(%Int %x)
declare %Int @atexit(void ()* %x)
declare %Double @atof([0 x %ConstChar]* %nptr)
declare %Int @atoi([0 x %ConstChar]* %nptr)
declare %LongInt @atol([0 x %ConstChar]* %nptr)
declare i8* @calloc(%SizeT %num, %SizeT %size)
declare void @exit(%Int %x)
declare void @free(i8* %ptr)
declare %Str* @getenv(%Str* %name)
declare %LongInt @labs(%LongInt %x)
declare %Str* @secure_getenv(%Str* %name)
declare i8* @malloc(%SizeT %size)
declare %Int @system([0 x %ConstChar]* %string)
; from included stdio
%File = type {
};

%FposT = type %Nat8;
%CharStr = type %Str;
%ConstCharStr = type %CharStr;
declare %Int @fclose(i8* %f)
declare %Int @feof(i8* %f)
declare %Int @ferror(i8* %f)
declare %Int @fflush(i8* %f)
declare %Int @fgetpos(i8* %f, %FposT* %pos)
declare i8* @fopen(%ConstCharStr* %fname, %ConstCharStr* %mode)
declare %SizeT @fread(i8* %buf, %SizeT %size, %SizeT %count, i8* %f)
declare %SizeT @fwrite(i8* %buf, %SizeT %size, %SizeT %count, i8* %f)
declare i8* @freopen(%ConstCharStr* %fname, %ConstCharStr* %mode, i8* %f)
declare %Int @fseek(i8* %f, %LongInt %offset, %Int %whence)
declare %Int @fsetpos(i8* %f, %FposT* %pos)
declare %LongInt @ftell(i8* %f)
declare %Int @remove(%ConstCharStr* %fname)
declare %Int @rename(%ConstCharStr* %old_filename, %ConstCharStr* %new_filename)
declare void @rewind(i8* %f)
declare void @setbuf(i8* %f, %CharStr* %buf)
declare %Int @setvbuf(i8* %f, %CharStr* %buf, %Int %mode, %SizeT %size)
declare i8* @tmpfile()
declare %CharStr* @tmpnam(%CharStr* %str)
declare %Int @printf(%ConstCharStr* %str, ...)
declare %Int @scanf(%ConstCharStr* %str, ...)
declare %Int @fprintf(i8* %f, %Str* %format, ...)
declare %Int @fscanf(i8* %f, %ConstCharStr* %format, ...)
declare %Int @sscanf(%ConstCharStr* %buf, %ConstCharStr* %format, ...)
declare %Int @sprintf(%CharStr* %buf, %ConstCharStr* %format, ...)
declare %Int @snprintf(%CharStr* %buf, %SizeT %size, %ConstCharStr* %format, ...)
declare %Int @vfprintf(i8* %f, %ConstCharStr* %format, %__VA_List %args)
declare %Int @vprintf(%ConstCharStr* %format, %__VA_List %args)
declare %Int @vsprintf(%CharStr* %str, %ConstCharStr* %format, %__VA_List %args)
declare %Int @vsnprintf(%CharStr* %str, %SizeT %n, %ConstCharStr* %format, %__VA_List %args)
declare %Int @__vsnprintf_chk(%CharStr* %dest, %SizeT %len, %Int %flags, %SizeT %dstlen, %ConstCharStr* %format, %__VA_List %arg)
declare %Int @fgetc(i8* %f)
declare %Int @fputc(%Int %char, i8* %f)
declare %CharStr* @fgets(%CharStr* %str, %Int %n, i8* %f)
declare %Int @fputs(%ConstCharStr* %str, i8* %f)
declare %Int @getc(i8* %f)
declare %Int @getchar()
declare %Int @putc(%Int %char, i8* %f)
declare %Int @putchar(%Int %char)
declare %Int @puts(%ConstCharStr* %str)
declare %Int @ungetc(%Int %char, i8* %f)
declare void @perror(%ConstCharStr* %str)
; -- end print includes --
; -- print imports 'main' --

; from import "builtin"

; end from import "builtin"
; from included ctypes

; from import "sdl"
%Window = type {
};

%Renderer = type {
};

%Texture = type {
};

%Rect = type {
	%Int32,
	%Int32,
	%Int32,
	%Int32
};

%Event = type {
};

declare external %Int32 @init(%Word32 %flags)
declare external void @shutdown()
declare external %ConstCharStr* @getError()
declare external %Int32 @setHint(%ConstCharStr* %name, %ConstCharStr* %value)
declare external void @delay(%Nat32 %ms)
declare external i8* @createWindow(%ConstCharStr* %title, %Int32 %x, %Int32 %y, %Int32 %w, %Int32 %h, %Word32 %flags)
declare external void @destroyWindow(i8* %window)
declare external i8* @createRenderer(i8* %window, %Int32 %index, %Word32 %flags)
declare external void @destroyRenderer(i8* %renderer)
declare external %Int32 @renderClear(i8* %renderer)
declare external %Int32 @renderCopy(i8* %renderer, i8* %texture, %Rect* %srcrect, %Rect* %dstrect)
declare external void @renderPresent(i8* %renderer)
declare external i8* @createTexture(i8* %renderer, %Nat32 %format, %Int32 %access, %Int32 %w, %Int32 %h)
declare external void @destroyTexture(i8* %texture)
declare external %Int32 @updateTexture(i8* %texture, %Rect* %rect, i8* %pixels, %Int32 %pitch)
declare external %Int32 @pollEvent(i8* %event)

; end from import "sdl"

; from import "display"
%display_MemMap = type i8* (%Nat32, %Nat32)*;
declare void @display_init(%display_MemMap %mm)
declare %Bool @display_isOn()
declare %Word32 @display_read32(%Nat32 %adr)
declare void @display_write32(%Nat32 %adr, %Word32 %value)
declare void @display_poll()
declare void @display_waitClose()
declare void @display_shutdown()

; end from import "display"

; from import "mmio"
declare void @mmio_write8(%Nat32 %adr, %Word8 %value)
declare void @mmio_write16(%Nat32 %adr, %Word16 %value)
declare void @mmio_write32(%Nat32 %adr, %Word32 %value)
declare %Word8 @mmio_read8(%Nat32 %adr)
declare %Word16 @mmio_read16(%Nat32 %adr)
declare %Word32 @mmio_read32(%Nat32 %adr)

; end from import "mmio"

; from import "bus"
declare %Word32 @bus_read(%Nat32 %adr, %Nat8 %size)
declare void @bus_write(%Nat32 %adr, %Word32 %value, %Nat8 %size)
declare i8* @bus_ramPtr(%Nat32 %adr, %Nat32 %size)
declare void @bus_memoryViolation(%Char8 %rw, %Nat32 %adr)
declare %Nat32 @bus_load_rom(%Str8* %filename)
declare void @bus_show_ram()

; end from import "bus"
; from included unistd
declare %Int @access([0 x %ConstChar]* %path, %Int %amode)
declare %UnsignedInt @alarm(%UnsignedInt %seconds)
declare %Int @brk(i8* %end_data_segment)
declare %Int @chdir([0 x %ConstChar]* %path)
declare %Int @chroot([0 x %ConstChar]* %path)
declare %Int @chown([0 x %ConstChar]* %pathname, %UIDT %owner, %GIDT %group)
declare %Int @close(%Int %fildes)
declare %SizeT @confstr(%Int %name, [0 x %Char]* %buf, %SizeT %len)
declare [0 x %Char]* @crypt([0 x %ConstChar]* %key, [0 x %ConstChar]* %salt)
declare [0 x %Char]* @ctermid([0 x %Char]* %s)
declare [0 x %Char]* @cuserid([0 x %Char]* %s)
declare %Int @dup(%Int %fildes)
declare %Int @dup2(%Int %fildes, %Int %fildes2)
declare void @encrypt([64 x %Char]* %block, %Int %edflag)
declare %Int @execl([0 x %ConstChar]* %path, [0 x %ConstChar]* %arg0, ...)
declare %Int @execle([0 x %ConstChar]* %path, [0 x %ConstChar]* %arg0, ...)
declare %Int @execlp([0 x %ConstChar]* %file, [0 x %ConstChar]* %arg0, ...)
declare %Int @execv([0 x %ConstChar]* %path, [0 x [0 x %ConstChar]*]* %argv)
declare %Int @execve([0 x %ConstChar]* %path, [0 x [0 x %ConstChar]*]* %argv, [0 x %ConstChar]* %envp)
declare %Int @execvp([0 x %ConstChar]* %file, [0 x [0 x %ConstChar]*]* %argv)
declare void @_exit(%Int %status)
declare %Int @fchown(%Int %fildes, %UIDT %owner, %GIDT %group)
declare %Int @fchdir(%Int %fildes)
declare %Int @fdatasync(%Int %fildes)
declare %PIDT @fork()
declare %LongInt @fpathconf(%Int %fildes, %Int %name)
declare %Int @fsync(%Int %fildes)
declare %Int @ftruncate(%Int %fildes, %OffT %length)
declare [0 x %Char]* @getcwd([0 x %Char]* %buf, %SizeT %size)
declare %Int @getdtablesize()
declare %GIDT @getegid()
declare %UIDT @geteuid()
declare %GIDT @getgid()
declare %Int @getgroups(%Int %gidsetsize, [0 x %GIDT]* %grouplist)
declare %Long @gethostid()
declare [0 x %Char]* @getlogin()
declare %Int @getlogin_r([0 x %Char]* %name, %SizeT %namesize)
declare %Int @getopt(%Int %argc, [0 x %ConstChar]* %argv, [0 x %ConstChar]* %optstring)
declare %Int @getpagesize()
declare [0 x %Char]* @getpass([0 x %ConstChar]* %prompt)
declare %PIDT @getpgid(%PIDT %pid)
declare %PIDT @getpgrp()
declare %PIDT @getpid()
declare %PIDT @getppid()
declare %PIDT @getsid(%PIDT %pid)
declare %UIDT @getuid()
declare [0 x %Char]* @getwd([0 x %Char]* %path_name)
declare %Int @isatty(%Int %fildes)
declare %Int @lchown([0 x %ConstChar]* %path, %UIDT %owner, %GIDT %group)
declare %Int @link([0 x %ConstChar]* %path1, [0 x %ConstChar]* %path2)
declare %Int @lockf(%Int %fildes, %Int %function, %OffT %size)
declare %OffT @lseek(%Int %fildes, %OffT %offset, %Int %whence)
declare %Int @nice(%Int %incr)
declare %LongInt @pathconf([0 x %ConstChar]* %path, %Int %name)
declare %Int @pause()
declare %Int @pipe([2 x %Int]* %fildes)
declare %SSizeT @pread(%Int %fildes, i8* %buf, %SizeT %nbyte, %OffT %offset)
declare %SSizeT @pwrite(%Int %fildes, i8* %buf, %SizeT %nbyte, %OffT %offset)
declare %SSizeT @read(%Int %fildes, i8* %buf, %SizeT %nbyte)
declare %Int @readlink([0 x %ConstChar]* %path, [0 x %Char]* %buf, %SizeT %bufsize)
declare %Int @rmdir([0 x %ConstChar]* %path)
declare i8* @sbrk(%IntPtrT %incr)
declare %Int @setgid(%GIDT %gid)
declare %Int @setpgid(%PIDT %pid, %PIDT %pgid)
declare %PIDT @setpgrp()
declare %Int @setregid(%GIDT %rgid, %GIDT %egid)
declare %Int @setreuid(%UIDT %ruid, %UIDT %euid)
declare %PIDT @setsid()
declare %Int @setuid(%UIDT %uid)
declare %UnsignedInt @sleep(%UnsignedInt %seconds)
declare void @swab(i8* %src, i8* %dst, %SSizeT %nbytes)
declare %Int @symlink([0 x %ConstChar]* %path1, [0 x %ConstChar]* %path2)
declare void @sync()
declare %LongInt @sysconf(%Int %name)
declare %PIDT @tcgetpgrp(%Int %fildes)
declare %Int @tcsetpgrp(%Int %fildes, %PIDT %pgid_id)
declare %Int @truncate([0 x %ConstChar]* %path, %OffT %length)
declare [0 x %Char]* @ttyname(%Int %fildes)
declare %Int @ttyname_r(%Int %fildes, [0 x %Char]* %name, %SizeT %namesize)
declare %USecondsT @ualarm(%USecondsT %useconds, %USecondsT %interval)
declare %Int @unlink([0 x %ConstChar]* %path)
declare %Int @usleep(%USecondsT %useconds)
declare %PIDT @vfork()
declare %SSizeT @write(%Int %fildes, i8* %buf, %SizeT %nbyte)
; from included decode
declare %Word8 @decode_extractOp(%Word32 %instr)
declare %Word8 @decode_extractFunct2(%Word32 %instr)
declare %Word8 @decode_extractFunct3(%Word32 %instr)
declare %Word8 @decode_extractFunct5(%Word32 %instr)
declare %Nat8 @decode_extractRd(%Word32 %instr)
declare %Nat8 @decode_extractRs1(%Word32 %instr)
declare %Nat8 @decode_extractRs2(%Word32 %instr)
declare %Word8 @decode_extractFunct7(%Word32 %instr)
declare %Word32 @decode_extractImm12(%Word32 %instr)
declare %Word32 @decode_extractImm31_12(%Word32 %instr)
declare %Int16 @decode_extractBImm(%Word32 %instr)
declare %Word32 @decode_extractJalImm(%Word32 %instr)
declare %Int32 @decode_expand12(%Word32 %val_12bit)
declare %Int32 @decode_expand20(%Word32 %val_20bit)

; from import "csr"

; end from import "csr"

; from import "rvHart"
%hart_Hart = type {
	[32 x %Word32],
	%Nat32,
	%hart_BusInterface*,
	%Bool,
	[4096 x %Word32]
};

declare void @hart_interrupt(%hart_Hart* %hart, %Word32 %int_num)
%hart_BusInterface = type {
	%Word32 (%Nat32, %Nat8)*,
	void (%Nat32, %Word32, %Nat8)*
};

declare void @hart_init(%hart_Hart* %hart, %Nat32 %id, %hart_BusInterface* %bus)
declare %Bool @hart_cycle(%hart_Hart* %hart)
declare %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csrno)
declare void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csrno, %Word32 %value)
declare void @hart_show_regs(%hart_Hart* %hart)

; end from import "rvHart"
; -- end print imports 'main' --
; -- strings --
@.str1 = private constant [11 x i8] [i8 82, i8 73, i8 83, i8 67, i8 45, i8 86, i8 32, i8 86, i8 77, i8 10, i8 0]
@.str2 = private constant [23 x i8] [i8 117, i8 115, i8 97, i8 103, i8 101, i8 58, i8 32, i8 37, i8 115, i8 32, i8 60, i8 105, i8 109, i8 97, i8 103, i8 101, i8 46, i8 98, i8 105, i8 110, i8 62, i8 10, i8 0]
@.str3 = private constant [82 x i8] [i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 62, i8 10, i8 0]
@.str4 = private constant [82 x i8] [i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 60, i8 10, i8 0]
@.str5 = private constant [13 x i8] [i8 109, i8 99, i8 121, i8 99, i8 108, i8 101, i8 32, i8 61, i8 32, i8 37, i8 117, i8 10, i8 0]
@.str6 = private constant [13 x i8] [i8 10, i8 67, i8 111, i8 114, i8 101, i8 32, i8 100, i8 117, i8 109, i8 112, i8 58, i8 10, i8 0]
@.str7 = private constant [2 x i8] [i8 10, i8 0]
; -- endstrings --
@hart = internal global %hart_Hart zeroinitializer
define %Int @main(%Int %argc, [0 x %Str8*]* %argv) {
	%1 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([11 x i8]* @.str1 to [0 x i8]*))
; if_0
	%2 = icmp slt %Int %argc, 2
	br %Bool %2 , label %then_0, label %endif_0
then_0:
	%3 = getelementptr [0 x %Str8*], [0 x %Str8*]* %argv, %Int32 0, %Int32 0
	%4 = load %Str8*, %Str8** %3
	%5 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([23 x i8]* @.str2 to [0 x i8]*), %Str8* %4)
	call void @exit(%Int 1)
	br label %endif_0
endif_0:
	%6 = getelementptr [0 x %Str8*], [0 x %Str8*]* %argv, %Int32 0, %Int32 1
	%7 = load %Str8*, %Str8** %6
	%8 = call %Nat32 @bus_load_rom(%Str8* %7)
; if_1
	%9 = icmp ule %Nat32 %8, 0
	br %Bool %9 , label %then_1, label %endif_1
then_1:
	call void @exit(%Int 1)
	br label %endif_1
endif_1:
	%10 = alloca %hart_BusInterface, align 8
	%11 = insertvalue %hart_BusInterface zeroinitializer, %Word32 (%Nat32, %Nat8)* @bus_read, 0
	%12 = insertvalue %hart_BusInterface %11, void (%Nat32, %Word32, %Nat8)* @bus_write, 1
	store %hart_BusInterface %12, %hart_BusInterface* %10
	call void @hart_init(%hart_Hart* @hart, %Nat32 0, %hart_BusInterface* %10)
	call void @display_init(i8* (%Nat32, %Nat32)* @bus_ramPtr)
	%13 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([82 x i8]* @.str3 to [0 x i8]*))
	%14 = alloca %Nat32, align 4
	store %Nat32 0, %Nat32* %14
	%15 = alloca %Nat32, align 4
	store %Nat32 0, %Nat32* %15
; while_1
	br label %again_1
again_1:
	br %Bool 1 , label %body_1, label %break_1
body_1:
; if_2
	%16 = call %Bool @hart_cycle(%hart_Hart* @hart)
	%17 = xor %Bool %16, 1
	br %Bool %17 , label %then_2, label %endif_2
then_2:
	br label %break_1
	br label %endif_2
endif_2:
	%19 = load %Nat32, %Nat32* %14
	%20 = add %Nat32 %19, 1
	store %Nat32 %20, %Nat32* %14
; if_3
	%21 = load %Nat32, %Nat32* %14
	%22 = icmp eq %Nat32 %21, 1000
	br %Bool %22 , label %then_3, label %endif_3
then_3:
	store %Nat32 0, %Nat32* %14
	%23 = zext i8 1 to %Word32
	call void @hart_interrupt(%hart_Hart* @hart, %Word32 %23)
	br label %endif_3
endif_3:
	%24 = load %Nat32, %Nat32* %15
	%25 = add %Nat32 %24, 1
	store %Nat32 %25, %Nat32* %15
; if_4
	%26 = load %Nat32, %Nat32* %15
	%27 = icmp eq %Nat32 %26, 100000
	br %Bool %27 , label %then_4, label %endif_4
then_4:
	store %Nat32 0, %Nat32* %15
	call void @display_poll()
	br label %endif_4
endif_4:
	br label %again_1
break_1:
	call void @display_shutdown()
	%28 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([82 x i8]* @.str4 to [0 x i8]*))
	%29 = call %Word32 @hart_getCsr(%hart_Hart* @hart, %Nat16 2816)
	%30 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([13 x i8]* @.str5 to [0 x i8]*), %Word32 %29)
	%31 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([13 x i8]* @.str6 to [0 x i8]*))
	call void @hart_show_regs(%hart_Hart* @hart)
	%32 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([2 x i8]* @.str7 to [0 x i8]*))
	call void @bus_show_ram()
	ret %Int 0
}


