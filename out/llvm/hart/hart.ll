
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


; MODULE: hart

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
; from included ctypes
; from included stdio
%FILE = type opaque;
%FposT = type %Nat8;
%CharStr = type %Str;
%ConstCharStr = type %CharStr;
declare %Int @fclose(%FILE* %f)
declare %Int @feof(%FILE* %f)
declare %Int @ferror(%FILE* %f)
declare %Int @fflush(%FILE* %f)
declare %Int @fgetpos(%FILE* %f, %FposT* %pos)
declare %FILE* @fopen(%ConstCharStr* %fname, %ConstCharStr* %mode)
declare %SizeT @fread(i8* %buf, %SizeT %size, %SizeT %count, %FILE* %f)
declare %SizeT @fwrite(i8* %buf, %SizeT %size, %SizeT %count, %FILE* %f)
declare %FILE* @freopen(%ConstCharStr* %fname, %ConstCharStr* %mode, %FILE* %f)
declare %Int @fseek(%FILE* %f, %LongInt %offset, %Int %whence)
declare %Int @fsetpos(%FILE* %f, %FposT* %pos)
declare %LongInt @ftell(%FILE* %f)
declare %Int @remove(%ConstCharStr* %fname)
declare %Int @rename(%ConstCharStr* %old_filename, %ConstCharStr* %new_filename)
declare void @rewind(%FILE* %f)
declare void @setbuf(%FILE* %f, %CharStr* %buf)
declare %Int @setvbuf(%FILE* %f, %CharStr* %buf, %Int %mode, %SizeT %size)
declare %FILE* @tmpfile()
declare %CharStr* @tmpnam(%CharStr* %str)
declare %Int @printf(%ConstCharStr* %str, ...)
declare %Int @scanf(%ConstCharStr* %str, ...)
declare %Int @fprintf(%FILE* %f, %Str* %format, ...)
declare %Int @fscanf(%FILE* %f, %ConstCharStr* %format, ...)
declare %Int @sscanf(%ConstCharStr* %buf, %ConstCharStr* %format, ...)
declare %Int @sprintf(%CharStr* %buf, %ConstCharStr* %format, ...)
declare %Int @snprintf(%CharStr* %buf, %SizeT %size, %ConstCharStr* %format, ...)
declare %Int @vfprintf(%FILE* %f, %ConstCharStr* %format, %__VA_List %args)
declare %Int @vprintf(%ConstCharStr* %format, %__VA_List %args)
declare %Int @vsprintf(%CharStr* %str, %ConstCharStr* %format, %__VA_List %args)
declare %Int @vsnprintf(%CharStr* %str, %SizeT %n, %ConstCharStr* %format, %__VA_List %args)
declare %Int @__vsnprintf_chk(%CharStr* %dest, %SizeT %len, %Int %flags, %SizeT %dstlen, %ConstCharStr* %format, %__VA_List %arg)
declare %Int @fgetc(%FILE* %f)
declare %Int @fputc(%Int %char, %FILE* %f)
declare %CharStr* @fgets(%CharStr* %str, %Int %n, %FILE* %f)
declare %Int @fputs(%ConstCharStr* %str, %FILE* %f)
declare %Int @getc(%FILE* %f)
declare %Int @getchar()
declare %Int @putc(%Int %char, %FILE* %f)
declare %Int @putchar(%Int %char)
declare %Int @puts(%ConstCharStr* %str)
declare %Int @ungetc(%Int %char, %FILE* %f)
declare void @perror(%ConstCharStr* %str)
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
; -- end print includes --
; -- print imports 'hart' --

; from import "builtin"

; end from import "builtin"

; from import "csr"

; end from import "csr"
; -- end print imports 'hart' --
; -- strings --
@.str1 = private constant [15 x i8] [i8 104, i8 97, i8 114, i8 116, i8 32, i8 35, i8 37, i8 100, i8 32, i8 105, i8 110, i8 105, i8 116, i8 10, i8 0]
@.str2 = private constant [15 x i8] [i8 10, i8 109, i8 99, i8 97, i8 117, i8 115, i8 101, i8 32, i8 35, i8 37, i8 48, i8 56, i8 88, i8 10, i8 0]
@.str3 = private constant [22 x i8] [i8 85, i8 78, i8 75, i8 78, i8 79, i8 87, i8 78, i8 32, i8 79, i8 80, i8 67, i8 79, i8 68, i8 69, i8 58, i8 32, i8 37, i8 48, i8 56, i8 88, i8 10, i8 0]
@.str4 = private constant [19 x i8] [i8 97, i8 100, i8 100, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str5 = private constant [19 x i8] [i8 115, i8 108, i8 108, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str6 = private constant [19 x i8] [i8 115, i8 108, i8 116, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str7 = private constant [20 x i8] [i8 115, i8 108, i8 116, i8 105, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str8 = private constant [19 x i8] [i8 120, i8 111, i8 114, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str9 = private constant [19 x i8] [i8 115, i8 114, i8 108, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str10 = private constant [19 x i8] [i8 115, i8 114, i8 97, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str11 = private constant [18 x i8] [i8 111, i8 114, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str12 = private constant [19 x i8] [i8 97, i8 110, i8 100, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str13 = private constant [19 x i8] [i8 109, i8 117, i8 108, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str14 = private constant [20 x i8] [i8 109, i8 117, i8 108, i8 104, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str15 = private constant [22 x i8] [i8 109, i8 117, i8 108, i8 104, i8 115, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str16 = private constant [21 x i8] [i8 109, i8 117, i8 108, i8 104, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str17 = private constant [19 x i8] [i8 100, i8 105, i8 118, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str18 = private constant [20 x i8] [i8 100, i8 105, i8 118, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str19 = private constant [19 x i8] [i8 114, i8 101, i8 109, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str20 = private constant [20 x i8] [i8 114, i8 101, i8 109, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str21 = private constant [19 x i8] [i8 97, i8 100, i8 100, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str22 = private constant [19 x i8] [i8 115, i8 117, i8 98, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str23 = private constant [19 x i8] [i8 115, i8 108, i8 108, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str24 = private constant [19 x i8] [i8 115, i8 108, i8 116, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str25 = private constant [20 x i8] [i8 115, i8 108, i8 116, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str26 = private constant [19 x i8] [i8 120, i8 111, i8 114, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str27 = private constant [19 x i8] [i8 115, i8 114, i8 108, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str28 = private constant [19 x i8] [i8 115, i8 114, i8 97, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str29 = private constant [18 x i8] [i8 111, i8 114, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str30 = private constant [19 x i8] [i8 97, i8 110, i8 100, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 10, i8 0]
@.str31 = private constant [15 x i8] [i8 108, i8 117, i8 105, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 48, i8 120, i8 37, i8 88, i8 10, i8 0]
@.str32 = private constant [17 x i8] [i8 97, i8 117, i8 105, i8 112, i8 99, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 48, i8 120, i8 37, i8 88, i8 10, i8 0]
@.str33 = private constant [13 x i8] [i8 106, i8 97, i8 108, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str34 = private constant [14 x i8] [i8 106, i8 97, i8 108, i8 114, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str35 = private constant [18 x i8] [i8 98, i8 101, i8 113, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str36 = private constant [18 x i8] [i8 98, i8 110, i8 101, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str37 = private constant [18 x i8] [i8 98, i8 108, i8 116, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str38 = private constant [18 x i8] [i8 98, i8 103, i8 101, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str39 = private constant [19 x i8] [i8 98, i8 108, i8 116, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str40 = private constant [19 x i8] [i8 98, i8 103, i8 101, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 10, i8 0]
@.str41 = private constant [17 x i8] [i8 108, i8 98, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str42 = private constant [17 x i8] [i8 108, i8 104, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str43 = private constant [17 x i8] [i8 108, i8 119, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str44 = private constant [18 x i8] [i8 108, i8 98, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str45 = private constant [18 x i8] [i8 108, i8 104, i8 117, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str46 = private constant [17 x i8] [i8 115, i8 98, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str47 = private constant [17 x i8] [i8 115, i8 104, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str48 = private constant [17 x i8] [i8 115, i8 119, i8 32, i8 120, i8 37, i8 100, i8 44, i8 32, i8 37, i8 100, i8 40, i8 120, i8 37, i8 100, i8 41, i8 10, i8 0]
@.str49 = private constant [7 x i8] [i8 101, i8 99, i8 97, i8 108, i8 108, i8 10, i8 0]
@.str50 = private constant [17 x i8] [i8 69, i8 67, i8 65, i8 76, i8 76, i8 58, i8 32, i8 104, i8 97, i8 114, i8 116, i8 32, i8 35, i8 37, i8 100, i8 10, i8 0]
@.str51 = private constant [6 x i8] [i8 109, i8 114, i8 101, i8 116, i8 10, i8 0]
@.str52 = private constant [8 x i8] [i8 101, i8 98, i8 114, i8 101, i8 97, i8 107, i8 10, i8 0]
@.str53 = private constant [18 x i8] [i8 69, i8 66, i8 82, i8 69, i8 65, i8 75, i8 58, i8 32, i8 104, i8 97, i8 114, i8 116, i8 32, i8 35, i8 37, i8 100, i8 10, i8 0]
@.str54 = private constant [34 x i8] [i8 85, i8 78, i8 75, i8 78, i8 79, i8 87, i8 78, i8 32, i8 83, i8 89, i8 83, i8 84, i8 69, i8 77, i8 32, i8 73, i8 78, i8 83, i8 84, i8 82, i8 85, i8 67, i8 84, i8 73, i8 79, i8 78, i8 58, i8 32, i8 48, i8 120, i8 37, i8 120, i8 10, i8 0]
@.str55 = private constant [7 x i8] [i8 80, i8 65, i8 85, i8 83, i8 69, i8 10, i8 0]
@.str56 = private constant [8 x i8] [i8 91, i8 37, i8 48, i8 56, i8 88, i8 93, i8 32, i8 0]
@.str57 = private constant [3 x i8] [i8 37, i8 99, i8 0]
@.str58 = private constant [8 x i8] [i8 91, i8 37, i8 48, i8 56, i8 88, i8 93, i8 32, i8 0]
@.str59 = private constant [33 x i8] [i8 10, i8 10, i8 73, i8 78, i8 83, i8 84, i8 82, i8 85, i8 67, i8 84, i8 73, i8 79, i8 78, i8 95, i8 78, i8 79, i8 84, i8 95, i8 73, i8 77, i8 80, i8 76, i8 69, i8 77, i8 69, i8 78, i8 84, i8 69, i8 68, i8 58, i8 32, i8 34, i8 0]
@.str60 = private constant [3 x i8] [i8 34, i8 10, i8 0]
@.str61 = private constant [15 x i8] [i8 120, i8 37, i8 48, i8 50, i8 100, i8 32, i8 61, i8 32, i8 48, i8 120, i8 37, i8 48, i8 56, i8 120, i8 0]
@.str62 = private constant [5 x i8] [i8 32, i8 32, i8 32, i8 32, i8 0]
@.str63 = private constant [16 x i8] [i8 120, i8 37, i8 48, i8 50, i8 100, i8 32, i8 61, i8 32, i8 48, i8 120, i8 37, i8 48, i8 56, i8 120, i8 10, i8 0]
; -- endstrings --
%hart_Hart = type {
	[32 x %Word32],
	%Nat32,
	%hart_BusInterface*,
	%Bool,
	[4096 x %Word32]
};

define void @hart_interrupt(%hart_Hart* %hart, %Word32 %int_num) {
	%1 = trunc %Word32 %int_num to %Nat8
	%2 = zext %Nat8 %1 to %Word32
	%3 = shl %Word32 1, %2
	%4 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 836)
	%5 = or %Word32 %4, %3
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 836, %Word32 %5)
	ret void
}

define internal %Nat32 @trap(%hart_Hart* %hart, %Word32 %cause, %Nat32 %epc) {
	%new_mstatus = alloca %Word32, align 4
	%1 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 768)
	%2 = xor %Word32 136, -1
	%3 = and %Word32 %1, %2
	store %Word32 %3, %Word32* %new_mstatus
; if_0
	%4 = and %Word32 %1, 8
	%5 = icmp ne %Word32 %4, 0
	br %Bool %5 , label %then_0, label %endif_0
then_0:
	%6 = load %Word32, %Word32* %new_mstatus
	%7 = or %Word32 %6, 128
	store %Word32 %7, %Word32* %new_mstatus
	br label %endif_0
endif_0:
	%8 = load %Word32, %Word32* %new_mstatus
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 768, %Word32 %8)
	%9 = bitcast %Nat32 %epc to %Word32
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 833, %Word32 %9)
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 834, %Word32 %cause)
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 835, %Word32 0)
	%10 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 773)
	%11 = xor %Word32 3, -1
	%12 = and %Word32 %10, %11
	%13 = bitcast %Word32 %12 to %Nat32
	ret %Nat32 %13
}

%hart_BusInterface = type {
	%Word32 (%Nat32, %Nat8)*,
	void (%Nat32, %Word32, %Nat8)*
};
; branch; jump and link by register; fence; machine return from trap
define void @hart_init(%hart_Hart* %hart, %Nat32 %id, %hart_BusInterface* %bus) {
	%1 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([15 x i8]* @.str1 to [0 x i8]*), %Nat32 %id)
	%2 = bitcast %Nat32 %id to %Word32
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 3860, %Word32 %2)
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 769, %Word32 1073746176)
	%3 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%4 = zext i8 32 to %Nat32
	%5 = mul %Nat32 %4, 4
	%6 = bitcast [32 x %Word32]* %3 to i8*
	call void (i8*, i8, i32, i1) @llvm.memset.p0.i32(i8* %6, i8 0, %Nat32 %5, i1 0)
	%7 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	store %Nat32 0, %Nat32* %7
	%8 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	store %hart_BusInterface* %bus, %hart_BusInterface** %8
	%9 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 3
	store %Bool 0, %Bool* %9
	ret void
}

define internal %Word32 @fetch(%hart_Hart* %hart) alwaysinline {
	%1 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%2 = load %Nat32, %Nat32* %1
	%3 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%4 = load %hart_BusInterface*, %hart_BusInterface** %3
	%5 = getelementptr %hart_BusInterface, %hart_BusInterface* %4, %Int32 0, %Int32 0
	%6 = load %Word32 (%Nat32, %Nat8)*, %Word32 (%Nat32, %Nat8)** %5
	%7 = call %Word32 %6(%Nat32 %2, %Nat8 4)
	ret %Word32 %7
}

define %Bool @hart_cycle(%hart_Hart* %hart) {
	%int_num = alloca %Nat8, align 1
	%1 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 836)
	%2 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 772)
	%3 = and %Word32 %1, %2
	%4 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 768)
	%5 = and %Word32 %4, 8
	%6 = icmp ne %Word32 %5, 0
; if_0
	%7 = icmp ne %Word32 %3, 0
	%8 = and %Bool %6, %7
	br %Bool %8 , label %then_0, label %endif_0
then_0:
	store %Nat8 0, %Nat8* %int_num
; while_1
	br label %again_1
again_1:
	%9 = load %Nat8, %Nat8* %int_num
	%10 = zext %Nat8 %9 to %Word32
	%11 = shl %Word32 1, %10
	%12 = and %Word32 %3, %11
	%13 = icmp eq %Word32 %12, 0
	br %Bool %13 , label %body_1, label %break_1
body_1:
	%14 = load %Nat8, %Nat8* %int_num
	%15 = add %Nat8 %14, 1
	store %Nat8 %15, %Nat8* %int_num
	br label %again_1
break_1:
	%16 = load %Nat8, %Nat8* %int_num
	%17 = zext %Nat8 %16 to %Word32
	%18 = shl %Word32 1, %17
	%19 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 836)
	%20 = xor %Word32 %18, -1
	%21 = and %Word32 %19, %20
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 836, %Word32 %21)
	%22 = load %Nat8, %Nat8* %int_num
	%23 = zext %Nat8 %22 to %Word32
	%24 = or %Word32 2147483648, %23
	%25 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%26 = load %Nat32, %Nat32* %25
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %26, %Str8* bitcast ([15 x i8]* @.str2 to [0 x i8]*), %Word32 %24)
	%27 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%28 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%29 = load %Nat32, %Nat32* %28
	%30 = call %Nat32 @trap(%hart_Hart* %hart, %Word32 %24, %Nat32 %29)
	store %Nat32 %30, %Nat32* %27
	br label %endif_0
endif_0:
	%31 = call %Word32 @fetch(%hart_Hart* %hart)
	call void @exec(%hart_Hart* %hart, %Word32 %31)
	%32 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 4
	%33 = zext %Nat16 2816 to %Nat32
	%34 = getelementptr [4096 x %Word32], [4096 x %Word32]* %32, %Int32 0, %Nat32 %33
	%35 = bitcast %Word32* %34 to %Nat32*
	%36 = load %Nat32, %Nat32* %35
	%37 = add %Nat32 %36, 1
	store %Nat32 %37, %Nat32* %35
	%38 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 3
	%39 = load %Bool, %Bool* %38
	%40 = xor %Bool %39, 1
	ret %Bool %40
}

define internal void @exec(%hart_Hart* %hart, %Word32 %instr) {
	%nexpc = alloca %Nat32, align 4
	%1 = call %Word8 @decode_extractOp(%Word32 %instr)
	%2 = call %Word8 @decode_extractFunct3(%Word32 %instr)
	%3 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%4 = getelementptr [32 x %Word32], [32 x %Word32]* %3, %Int32 0, %Int32 0
	store %Word32 0, %Word32* %4
	%5 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%6 = load %Nat32, %Nat32* %5
	%7 = add %Nat32 %6, 4
	store %Nat32 %7, %Nat32* %nexpc
; if_0
	%8 = icmp eq %Word8 %1, 19
	br %Bool %8 , label %then_0, label %else_0
then_0:
	call void @execI(%hart_Hart* %hart, %Word32 %instr)
	br label %endif_0
else_0:
; if_1
	%9 = icmp eq %Word8 %1, 51
	br %Bool %9 , label %then_1, label %else_1
then_1:
	call void @execR(%hart_Hart* %hart, %Word32 %instr)
	br label %endif_1
else_1:
; if_2
	%10 = icmp eq %Word8 %1, 55
	br %Bool %10 , label %then_2, label %else_2
then_2:
	call void @execLUI(%hart_Hart* %hart, %Word32 %instr)
	br label %endif_2
else_2:
; if_3
	%11 = icmp eq %Word8 %1, 23
	br %Bool %11 , label %then_3, label %else_3
then_3:
	call void @execAUIPC(%hart_Hart* %hart, %Word32 %instr)
	br label %endif_3
else_3:
; if_4
	%12 = icmp eq %Word8 %1, 111
	br %Bool %12 , label %then_4, label %else_4
then_4:
	%13 = call %Nat32 @execJAL(%hart_Hart* %hart, %Word32 %instr)
	store %Nat32 %13, %Nat32* %nexpc
	br label %endif_4
else_4:
; if_5
	%14 = icmp eq %Word8 %1, 103
	%15 = icmp eq %Word8 %2, 0
	%16 = and %Bool %14, %15
	br %Bool %16 , label %then_5, label %else_5
then_5:
	%17 = call %Nat32 @execJALR(%hart_Hart* %hart, %Word32 %instr)
	store %Nat32 %17, %Nat32* %nexpc
	br label %endif_5
else_5:
; if_6
	%18 = icmp eq %Word8 %1, 99
	br %Bool %18 , label %then_6, label %else_6
then_6:
	%19 = call %Nat32 @execB(%hart_Hart* %hart, %Word32 %instr)
	store %Nat32 %19, %Nat32* %nexpc
	br label %endif_6
else_6:
; if_7
	%20 = icmp eq %Word8 %1, 3
	br %Bool %20 , label %then_7, label %else_7
then_7:
	call void @execL(%hart_Hart* %hart, %Word32 %instr)
	br label %endif_7
else_7:
; if_8
	%21 = icmp eq %Word8 %1, 35
	br %Bool %21 , label %then_8, label %else_8
then_8:
	call void @execS(%hart_Hart* %hart, %Word32 %instr)
	br label %endif_8
else_8:
; if_9
	%22 = icmp eq %Word8 %1, 115
	br %Bool %22 , label %then_9, label %else_9
then_9:
	%23 = load %Nat32, %Nat32* %nexpc
	%24 = call %Nat32 @execSystem(%hart_Hart* %hart, %Word32 %instr, %Nat32 %23)
	store %Nat32 %24, %Nat32* %nexpc
	br label %endif_9
else_9:
; if_10
	%25 = icmp eq %Word8 %1, 15
	br %Bool %25 , label %then_10, label %else_10
then_10:
	call void @execFence(%hart_Hart* %hart, %Word32 %instr)
	br label %endif_10
else_10:
	%26 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%27 = load %Nat32, %Nat32* %26
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %27, %Str8* bitcast ([22 x i8]* @.str3 to [0 x i8]*), %Word8 %1)
	br label %endif_10
endif_10:
	br label %endif_9
endif_9:
	br label %endif_8
endif_8:
	br label %endif_7
endif_7:
	br label %endif_6
endif_6:
	br label %endif_5
endif_5:
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	%28 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%29 = load %Nat32, %Nat32* %nexpc
	store %Nat32 %29, %Nat32* %28
	ret void
}

define internal void @execI(%hart_Hart* %hart, %Word32 %instr) {
	%result = alloca %Word32, align 4
	%1 = call %Word8 @decode_extractFunct3(%Word32 %instr)
	%2 = call %Word8 @decode_extractFunct7(%Word32 %instr)
	%3 = call %Word32 @decode_extractImm12(%Word32 %instr)
	%4 = call %Int32 @decode_expand12(%Word32 %3)
	%5 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%6 = call %Nat8 @decode_extractRs1(%Word32 %instr)
	store %Word32 0, %Word32* %result
; if_0
	%7 = icmp eq %Word8 %1, 0
	br %Bool %7 , label %then_0, label %else_0
then_0:
	%8 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%9 = load %Nat32, %Nat32* %8
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %9, %Str8* bitcast ([19 x i8]* @.str4 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%10 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%11 = zext %Nat8 %6 to %Nat32
	%12 = getelementptr [32 x %Word32], [32 x %Word32]* %10, %Int32 0, %Nat32 %11
	%13 = load %Word32, %Word32* %12
	%14 = bitcast %Word32 %13 to %Int32
	%15 = add %Int32 %14, %4
	%16 = bitcast %Int32 %15 to %Word32
	store %Word32 %16, %Word32* %result
	br label %endif_0
else_0:
; if_1
	%17 = icmp eq %Word8 %1, 1
	%18 = icmp eq %Word8 %2, 0
	%19 = and %Bool %17, %18
	br %Bool %19 , label %then_1, label %else_1
then_1:
	%20 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%21 = load %Nat32, %Nat32* %20
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %21, %Str8* bitcast ([19 x i8]* @.str5 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%22 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%23 = zext %Nat8 %6 to %Nat32
	%24 = getelementptr [32 x %Word32], [32 x %Word32]* %22, %Int32 0, %Nat32 %23
	%25 = load %Word32, %Word32* %24
	%26 = trunc %Int32 %4 to %Nat8
	%27 = zext %Nat8 %26 to %Word32
	%28 = shl %Word32 %25, %27
	store %Word32 %28, %Word32* %result
	br label %endif_1
else_1:
; if_2
	%29 = icmp eq %Word8 %1, 2
	br %Bool %29 , label %then_2, label %else_2
then_2:
	%30 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%31 = load %Nat32, %Nat32* %30
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %31, %Str8* bitcast ([19 x i8]* @.str6 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%32 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%33 = zext %Nat8 %6 to %Nat32
	%34 = getelementptr [32 x %Word32], [32 x %Word32]* %32, %Int32 0, %Nat32 %33
	%35 = load %Word32, %Word32* %34
	%36 = bitcast %Word32 %35 to %Int32
	%37 = icmp slt %Int32 %36, %4
	%38 = zext %Bool %37 to %Word32
	store %Word32 %38, %Word32* %result
	br label %endif_2
else_2:
; if_3
	%39 = icmp eq %Word8 %1, 3
	br %Bool %39 , label %then_3, label %else_3
then_3:
	%40 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%41 = load %Nat32, %Nat32* %40
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %41, %Str8* bitcast ([20 x i8]* @.str7 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%42 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%43 = zext %Nat8 %6 to %Nat32
	%44 = getelementptr [32 x %Word32], [32 x %Word32]* %42, %Int32 0, %Nat32 %43
	%45 = load %Word32, %Word32* %44
	%46 = bitcast %Word32 %45 to %Nat32
	%47 = bitcast %Int32 %4 to %Nat32
	%48 = icmp ult %Nat32 %46, %47
	%49 = zext %Bool %48 to %Word32
	store %Word32 %49, %Word32* %result
	br label %endif_3
else_3:
; if_4
	%50 = icmp eq %Word8 %1, 4
	br %Bool %50 , label %then_4, label %else_4
then_4:
	%51 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%52 = load %Nat32, %Nat32* %51
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %52, %Str8* bitcast ([19 x i8]* @.str8 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%53 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%54 = zext %Nat8 %6 to %Nat32
	%55 = getelementptr [32 x %Word32], [32 x %Word32]* %53, %Int32 0, %Nat32 %54
	%56 = bitcast %Int32 %4 to %Word32
	%57 = load %Word32, %Word32* %55
	%58 = xor %Word32 %57, %56
	store %Word32 %58, %Word32* %result
	br label %endif_4
else_4:
; if_5
	%59 = icmp eq %Word8 %1, 5
	%60 = icmp eq %Word8 %2, 0
	%61 = and %Bool %59, %60
	br %Bool %61 , label %then_5, label %else_5
then_5:
	%62 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%63 = load %Nat32, %Nat32* %62
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %63, %Str8* bitcast ([19 x i8]* @.str9 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%64 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%65 = zext %Nat8 %6 to %Nat32
	%66 = getelementptr [32 x %Word32], [32 x %Word32]* %64, %Int32 0, %Nat32 %65
	%67 = load %Word32, %Word32* %66
	%68 = trunc %Int32 %4 to %Nat8
	%69 = zext %Nat8 %68 to %Word32
	%70 = lshr %Word32 %67, %69
	store %Word32 %70, %Word32* %result
	br label %endif_5
else_5:
; if_6
	%71 = icmp eq %Word8 %1, 5
	%72 = icmp eq %Word8 %2, 32
	%73 = and %Bool %71, %72
	br %Bool %73 , label %then_6, label %else_6
then_6:
	%74 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%75 = load %Nat32, %Nat32* %74
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %75, %Str8* bitcast ([19 x i8]* @.str10 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%76 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%77 = zext %Nat8 %6 to %Nat32
	%78 = getelementptr [32 x %Word32], [32 x %Word32]* %76, %Int32 0, %Nat32 %77
	%79 = load %Word32, %Word32* %78
	%80 = sext %Word32 %79 to %Int64
	%81 = bitcast %Int64 %80 to %Word64
	%82 = trunc %Int32 %4 to %Nat8
	%83 = zext %Nat8 %82 to %Word64
	%84 = lshr %Word64 %81, %83
	%85 = trunc %Word64 %84 to %Word32
	store %Word32 %85, %Word32* %result
	br label %endif_6
else_6:
; if_7
	%86 = icmp eq %Word8 %1, 6
	br %Bool %86 , label %then_7, label %else_7
then_7:
	%87 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%88 = load %Nat32, %Nat32* %87
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %88, %Str8* bitcast ([18 x i8]* @.str11 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%89 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%90 = zext %Nat8 %6 to %Nat32
	%91 = getelementptr [32 x %Word32], [32 x %Word32]* %89, %Int32 0, %Nat32 %90
	%92 = bitcast %Int32 %4 to %Word32
	%93 = load %Word32, %Word32* %91
	%94 = or %Word32 %93, %92
	store %Word32 %94, %Word32* %result
	br label %endif_7
else_7:
; if_8
	%95 = icmp eq %Word8 %1, 7
	br %Bool %95 , label %then_8, label %else_8
then_8:
	%96 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%97 = load %Nat32, %Nat32* %96
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %97, %Str8* bitcast ([19 x i8]* @.str12 to [0 x i8]*), %Nat8 %5, %Nat8 %6, %Int32 %4)
	%98 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%99 = zext %Nat8 %6 to %Nat32
	%100 = getelementptr [32 x %Word32], [32 x %Word32]* %98, %Int32 0, %Nat32 %99
	%101 = bitcast %Int32 %4 to %Word32
	%102 = load %Word32, %Word32* %100
	%103 = and %Word32 %102, %101
	store %Word32 %103, %Word32* %result
	br label %endif_8
else_8:
	br label %endif_8
endif_8:
	br label %endif_7
endif_7:
	br label %endif_6
endif_6:
	br label %endif_5
endif_5:
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	%104 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%105 = zext %Nat8 %5 to %Nat32
	%106 = getelementptr [32 x %Word32], [32 x %Word32]* %104, %Int32 0, %Nat32 %105
	%107 = load %Word32, %Word32* %result
	store %Word32 %107, %Word32* %106
	ret void
}

define internal void @execR(%hart_Hart* %hart, %Word32 %instr) {
	%result = alloca %Word32, align 4
	%1 = call %Word8 @decode_extractFunct3(%Word32 %instr)
	%2 = call %Word8 @decode_extractFunct7(%Word32 %instr)
	%3 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%4 = call %Nat8 @decode_extractRs1(%Word32 %instr)
	%5 = call %Nat8 @decode_extractRs2(%Word32 %instr)
	%6 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%7 = zext %Nat8 %4 to %Nat32
	%8 = getelementptr [32 x %Word32], [32 x %Word32]* %6, %Int32 0, %Nat32 %7
	%9 = load %Word32, %Word32* %8
	%10 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%11 = zext %Nat8 %5 to %Nat32
	%12 = getelementptr [32 x %Word32], [32 x %Word32]* %10, %Int32 0, %Nat32 %11
	%13 = load %Word32, %Word32* %12
	store %Word32 0, %Word32* %result
; if_0
	%14 = icmp eq %Word8 %2, 1
	br %Bool %14 , label %then_0, label %else_0
then_0:
; if_1
	%15 = icmp eq %Word8 %1, 0
	br %Bool %15 , label %then_1, label %else_1
then_1:
	%16 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%17 = load %Nat32, %Nat32* %16
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %17, %Str8* bitcast ([19 x i8]* @.str13 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%18 = bitcast %Word32 %9 to %Int32
	%19 = bitcast %Word32 %13 to %Int32
	%20 = mul %Int32 %18, %19
	%21 = bitcast %Int32 %20 to %Word32
	store %Word32 %21, %Word32* %result
	br label %endif_1
else_1:
; if_2
	%22 = icmp eq %Word8 %1, 1
	br %Bool %22 , label %then_2, label %else_2
then_2:
	%23 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%24 = load %Nat32, %Nat32* %23
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %24, %Str8* bitcast ([20 x i8]* @.str14 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%25 = sext %Word32 %9 to %Int64
	%26 = sext %Word32 %13 to %Int64
	%27 = mul %Int64 %25, %26
	%28 = bitcast %Int64 %27 to %Word64
	%29 = zext i8 32 to %Word64
	%30 = lshr %Word64 %28, %29
	%31 = trunc %Word64 %30 to %Word32
	store %Word32 %31, %Word32* %result
	br label %endif_2
else_2:
; if_3
	%32 = icmp eq %Word8 %1, 2
	br %Bool %32 , label %then_3, label %else_3
then_3:
	%33 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%34 = load %Nat32, %Nat32* %33
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %34, %Str8* bitcast ([22 x i8]* @.str15 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%35 = sext %Word32 %9 to %Int64
	%36 = zext %Word32 %13 to %Nat64
	%37 = bitcast %Nat64 %36 to %Int64
	%38 = mul %Int64 %35, %37
	%39 = bitcast %Int64 %38 to %Word64
	%40 = zext i8 32 to %Word64
	%41 = lshr %Word64 %39, %40
	%42 = trunc %Word64 %41 to %Word32
	store %Word32 %42, %Word32* %result
	br label %endif_3
else_3:
; if_4
	%43 = icmp eq %Word8 %1, 3
	br %Bool %43 , label %then_4, label %else_4
then_4:
	%44 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%45 = load %Nat32, %Nat32* %44
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %45, %Str8* bitcast ([21 x i8]* @.str16 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%46 = zext %Word32 %9 to %Nat64
	%47 = zext %Word32 %13 to %Nat64
	%48 = mul %Nat64 %46, %47
	%49 = bitcast %Nat64 %48 to %Word64
	%50 = zext i8 32 to %Word64
	%51 = lshr %Word64 %49, %50
	%52 = trunc %Word64 %51 to %Word32
	store %Word32 %52, %Word32* %result
	br label %endif_4
else_4:
; if_5
	%53 = icmp eq %Word8 %1, 4
	br %Bool %53 , label %then_5, label %else_5
then_5:
	%54 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%55 = load %Nat32, %Nat32* %54
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %55, %Str8* bitcast ([19 x i8]* @.str17 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%56 = bitcast %Word32 %9 to %Int32
	%57 = bitcast %Word32 %13 to %Int32
	%58 = sdiv %Int32 %56, %57
	%59 = bitcast %Int32 %58 to %Word32
	store %Word32 %59, %Word32* %result
	br label %endif_5
else_5:
; if_6
	%60 = icmp eq %Word8 %1, 5
	br %Bool %60 , label %then_6, label %else_6
then_6:
	%61 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%62 = load %Nat32, %Nat32* %61
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %62, %Str8* bitcast ([20 x i8]* @.str18 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%63 = bitcast %Word32 %9 to %Nat32
	%64 = bitcast %Word32 %13 to %Nat32
	%65 = udiv %Nat32 %63, %64
	%66 = bitcast %Nat32 %65 to %Word32
	store %Word32 %66, %Word32* %result
	br label %endif_6
else_6:
; if_7
	%67 = icmp eq %Word8 %1, 6
	br %Bool %67 , label %then_7, label %else_7
then_7:
	%68 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%69 = load %Nat32, %Nat32* %68
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %69, %Str8* bitcast ([19 x i8]* @.str19 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%70 = bitcast %Word32 %9 to %Int32
	%71 = bitcast %Word32 %13 to %Int32
	%72 = srem %Int32 %70, %71
	%73 = bitcast %Int32 %72 to %Word32
	store %Word32 %73, %Word32* %result
	br label %endif_7
else_7:
; if_8
	%74 = icmp eq %Word8 %1, 7
	br %Bool %74 , label %then_8, label %endif_8
then_8:
	%75 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%76 = load %Nat32, %Nat32* %75
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %76, %Str8* bitcast ([20 x i8]* @.str20 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%77 = bitcast %Word32 %9 to %Nat32
	%78 = bitcast %Word32 %13 to %Nat32
	%79 = urem %Nat32 %77, %78
	%80 = bitcast %Nat32 %79 to %Word32
	store %Word32 %80, %Word32* %result
	br label %endif_8
endif_8:
	br label %endif_7
endif_7:
	br label %endif_6
endif_6:
	br label %endif_5
endif_5:
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
else_0:
; if_9
	%81 = icmp eq %Word8 %1, 0
	%82 = icmp eq %Word8 %2, 0
	%83 = and %Bool %81, %82
	br %Bool %83 , label %then_9, label %else_9
then_9:
	%84 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%85 = load %Nat32, %Nat32* %84
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %85, %Str8* bitcast ([19 x i8]* @.str21 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%86 = bitcast %Word32 %9 to %Int32
	%87 = bitcast %Word32 %13 to %Int32
	%88 = add %Int32 %86, %87
	%89 = bitcast %Int32 %88 to %Word32
	store %Word32 %89, %Word32* %result
	br label %endif_9
else_9:
; if_10
	%90 = icmp eq %Word8 %1, 0
	%91 = icmp eq %Word8 %2, 32
	%92 = and %Bool %90, %91
	br %Bool %92 , label %then_10, label %else_10
then_10:
	%93 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%94 = load %Nat32, %Nat32* %93
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %94, %Str8* bitcast ([19 x i8]* @.str22 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%95 = bitcast %Word32 %9 to %Int32
	%96 = bitcast %Word32 %13 to %Int32
	%97 = sub %Int32 %95, %96
	%98 = bitcast %Int32 %97 to %Word32
	store %Word32 %98, %Word32* %result
	br label %endif_10
else_10:
; if_11
	%99 = icmp eq %Word8 %1, 1
	br %Bool %99 , label %then_11, label %else_11
then_11:
	%100 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%101 = load %Nat32, %Nat32* %100
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %101, %Str8* bitcast ([19 x i8]* @.str23 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%102 = trunc %Word32 %13 to %Nat8
	%103 = zext %Nat8 %102 to %Word32
	%104 = shl %Word32 %9, %103
	store %Word32 %104, %Word32* %result
	br label %endif_11
else_11:
; if_12
	%105 = icmp eq %Word8 %1, 2
	br %Bool %105 , label %then_12, label %else_12
then_12:
	%106 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%107 = load %Nat32, %Nat32* %106
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %107, %Str8* bitcast ([19 x i8]* @.str24 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%108 = bitcast %Word32 %9 to %Int32
	%109 = bitcast %Word32 %13 to %Int32
	%110 = icmp slt %Int32 %108, %109
	%111 = zext %Bool %110 to %Word32
	store %Word32 %111, %Word32* %result
	br label %endif_12
else_12:
; if_13
	%112 = icmp eq %Word8 %1, 3
	br %Bool %112 , label %then_13, label %else_13
then_13:
	%113 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%114 = load %Nat32, %Nat32* %113
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %114, %Str8* bitcast ([20 x i8]* @.str25 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%115 = bitcast %Word32 %9 to %Nat32
	%116 = bitcast %Word32 %13 to %Nat32
	%117 = icmp ult %Nat32 %115, %116
	%118 = zext %Bool %117 to %Word32
	store %Word32 %118, %Word32* %result
	br label %endif_13
else_13:
; if_14
	%119 = icmp eq %Word8 %1, 4
	br %Bool %119 , label %then_14, label %else_14
then_14:
	%120 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%121 = load %Nat32, %Nat32* %120
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %121, %Str8* bitcast ([19 x i8]* @.str26 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%122 = xor %Word32 %9, %13
	store %Word32 %122, %Word32* %result
	br label %endif_14
else_14:
; if_15
	%123 = icmp eq %Word8 %1, 5
	%124 = icmp eq %Word8 %2, 0
	%125 = and %Bool %123, %124
	br %Bool %125 , label %then_15, label %else_15
then_15:
	%126 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%127 = load %Nat32, %Nat32* %126
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %127, %Str8* bitcast ([19 x i8]* @.str27 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%128 = trunc %Word32 %13 to %Nat8
	%129 = zext %Nat8 %128 to %Word32
	%130 = lshr %Word32 %9, %129
	store %Word32 %130, %Word32* %result
	br label %endif_15
else_15:
; if_16
	%131 = icmp eq %Word8 %1, 5
	%132 = icmp eq %Word8 %2, 32
	%133 = and %Bool %131, %132
	br %Bool %133 , label %then_16, label %else_16
then_16:
	%134 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%135 = load %Nat32, %Nat32* %134
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %135, %Str8* bitcast ([19 x i8]* @.str28 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%136 = sext %Word32 %9 to %Int64
	%137 = bitcast %Int64 %136 to %Word64
	%138 = trunc %Word32 %13 to %Nat8
	%139 = zext %Nat8 %138 to %Word64
	%140 = lshr %Word64 %137, %139
	%141 = trunc %Word64 %140 to %Word32
	store %Word32 %141, %Word32* %result
	br label %endif_16
else_16:
; if_17
	%142 = icmp eq %Word8 %1, 6
	br %Bool %142 , label %then_17, label %else_17
then_17:
	%143 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%144 = load %Nat32, %Nat32* %143
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %144, %Str8* bitcast ([18 x i8]* @.str29 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%145 = or %Word32 %9, %13
	store %Word32 %145, %Word32* %result
	br label %endif_17
else_17:
; if_18
	%146 = icmp eq %Word8 %1, 7
	br %Bool %146 , label %then_18, label %endif_18
then_18:
	%147 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%148 = load %Nat32, %Nat32* %147
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %148, %Str8* bitcast ([19 x i8]* @.str30 to [0 x i8]*), %Nat8 %3, %Nat8 %4, %Nat8 %5)
	%149 = and %Word32 %9, %13
	store %Word32 %149, %Word32* %result
	br label %endif_18
endif_18:
	br label %endif_17
endif_17:
	br label %endif_16
endif_16:
	br label %endif_15
endif_15:
	br label %endif_14
endif_14:
	br label %endif_13
endif_13:
	br label %endif_12
endif_12:
	br label %endif_11
endif_11:
	br label %endif_10
endif_10:
	br label %endif_9
endif_9:
	br label %endif_0
endif_0:
	%150 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%151 = zext %Nat8 %3 to %Nat32
	%152 = getelementptr [32 x %Word32], [32 x %Word32]* %150, %Int32 0, %Nat32 %151
	%153 = load %Word32, %Word32* %result
	store %Word32 %153, %Word32* %152
	ret void
}

define internal void @execLUI(%hart_Hart* %hart, %Word32 %instr) {
	%1 = call %Word32 @decode_extractImm31_12(%Word32 %instr)
	%2 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%3 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%4 = load %Nat32, %Nat32* %3
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %4, %Str8* bitcast ([15 x i8]* @.str31 to [0 x i8]*), %Nat8 %2, %Word32 %1)
	%5 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%6 = zext %Nat8 %2 to %Nat32
	%7 = getelementptr [32 x %Word32], [32 x %Word32]* %5, %Int32 0, %Nat32 %6
	%8 = zext i8 12 to %Word32
	%9 = shl %Word32 %1, %8
	store %Word32 %9, %Word32* %7
	ret void
}

define internal void @execAUIPC(%hart_Hart* %hart, %Word32 %instr) {
	%1 = call %Word32 @decode_extractImm31_12(%Word32 %instr)
	%2 = call %Int32 @decode_expand12(%Word32 %1)
	%3 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%4 = bitcast %Int32 %2 to %Word32
	%5 = zext i8 12 to %Word32
	%6 = shl %Word32 %4, %5
	%7 = bitcast %Word32 %6 to %Nat32
	%8 = load %Nat32, %Nat32* %3
	%9 = add %Nat32 %8, %7
	%10 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%11 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%12 = load %Nat32, %Nat32* %11
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %12, %Str8* bitcast ([17 x i8]* @.str32 to [0 x i8]*), %Nat8 %10, %Int32 %2)
	%13 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%14 = zext %Nat8 %10 to %Nat32
	%15 = getelementptr [32 x %Word32], [32 x %Word32]* %13, %Int32 0, %Nat32 %14
	%16 = bitcast %Nat32 %9 to %Word32
	store %Word32 %16, %Word32* %15
	ret void
}

define internal %Nat32 @execJAL(%hart_Hart* %hart, %Word32 %instr) {
	%1 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%2 = call %Word32 @decode_extractJalImm(%Word32 %instr)
	%3 = call %Int32 @decode_expand20(%Word32 %2)
	%4 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%5 = load %Nat32, %Nat32* %4
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %5, %Str8* bitcast ([13 x i8]* @.str33 to [0 x i8]*), %Nat8 %1, %Int32 %3)
	%6 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%7 = zext %Nat8 %1 to %Nat32
	%8 = getelementptr [32 x %Word32], [32 x %Word32]* %6, %Int32 0, %Nat32 %7
	%9 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%10 = load %Nat32, %Nat32* %9
	%11 = add %Nat32 %10, 4
	%12 = bitcast %Nat32 %11 to %Word32
	store %Word32 %12, %Word32* %8
	%13 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%14 = load %Nat32, %Nat32* %13
	%15 = bitcast %Nat32 %14 to %Int32
	%16 = add %Int32 %15, %3
	%17 = bitcast %Int32 %16 to %Nat32
	ret %Nat32 %17
}

define internal %Nat32 @execJALR(%hart_Hart* %hart, %Word32 %instr) {
	%1 = call %Nat8 @decode_extractRs1(%Word32 %instr)
	%2 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%3 = call %Word32 @decode_extractImm12(%Word32 %instr)
	%4 = call %Int32 @decode_expand12(%Word32 %3)
	%5 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%6 = load %Nat32, %Nat32* %5
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %6, %Str8* bitcast ([14 x i8]* @.str34 to [0 x i8]*), %Int32 %4, %Nat8 %1)
	%7 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%8 = load %Nat32, %Nat32* %7
	%9 = add %Nat32 %8, 4
	%10 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%11 = zext %Nat8 %1 to %Nat32
	%12 = getelementptr [32 x %Word32], [32 x %Word32]* %10, %Int32 0, %Nat32 %11
	%13 = load %Word32, %Word32* %12
	%14 = bitcast %Word32 %13 to %Int32
	%15 = add %Int32 %14, %4
	%16 = bitcast %Int32 %15 to %Word32
	%17 = and %Word32 %16, 4294967294
	%18 = bitcast %Word32 %17 to %Nat32
	%19 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%20 = zext %Nat8 %2 to %Nat32
	%21 = getelementptr [32 x %Word32], [32 x %Word32]* %19, %Int32 0, %Nat32 %20
	%22 = bitcast %Nat32 %9 to %Word32
	store %Word32 %22, %Word32* %21
	ret %Nat32 %18
}

define internal %Nat32 @execB(%hart_Hart* %hart, %Word32 %instr) {
	%nexpc = alloca %Nat32, align 4
	%1 = call %Word8 @decode_extractFunct3(%Word32 %instr)
	%2 = call %Nat8 @decode_extractRs1(%Word32 %instr)
	%3 = call %Nat8 @decode_extractRs2(%Word32 %instr)
	%4 = call %Int16 @decode_extractBImm(%Word32 %instr)
	%5 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%6 = zext %Nat8 %2 to %Nat32
	%7 = getelementptr [32 x %Word32], [32 x %Word32]* %5, %Int32 0, %Nat32 %6
	%8 = load %Word32, %Word32* %7
	%9 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%10 = zext %Nat8 %3 to %Nat32
	%11 = getelementptr [32 x %Word32], [32 x %Word32]* %9, %Int32 0, %Nat32 %10
	%12 = load %Word32, %Word32* %11
	%13 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%14 = load %Nat32, %Nat32* %13
	%15 = add %Nat32 %14, 4
	store %Nat32 %15, %Nat32* %nexpc
; if_0
	%16 = icmp eq %Word8 %1, 0
	br %Bool %16 , label %then_0, label %else_0
then_0:
	%17 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%18 = load %Nat32, %Nat32* %17
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %18, %Str8* bitcast ([18 x i8]* @.str35 to [0 x i8]*), %Nat8 %2, %Nat8 %3, %Int16 %4)
; if_1
	%19 = icmp eq %Word32 %8, %12
	br %Bool %19 , label %then_1, label %endif_1
then_1:
	%20 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%21 = load %Nat32, %Nat32* %20
	%22 = bitcast %Nat32 %21 to %Int32
	%23 = sext %Int16 %4 to %Int32
	%24 = add %Int32 %22, %23
	%25 = bitcast %Int32 %24 to %Nat32
	store %Nat32 %25, %Nat32* %nexpc
	br label %endif_1
endif_1:
	br label %endif_0
else_0:
; if_2
	%26 = icmp eq %Word8 %1, 1
	br %Bool %26 , label %then_2, label %else_2
then_2:
	%27 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%28 = load %Nat32, %Nat32* %27
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %28, %Str8* bitcast ([18 x i8]* @.str36 to [0 x i8]*), %Nat8 %2, %Nat8 %3, %Int16 %4)
; if_3
	%29 = icmp ne %Word32 %8, %12
	br %Bool %29 , label %then_3, label %endif_3
then_3:
	%30 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%31 = load %Nat32, %Nat32* %30
	%32 = bitcast %Nat32 %31 to %Int32
	%33 = sext %Int16 %4 to %Int32
	%34 = add %Int32 %32, %33
	%35 = bitcast %Int32 %34 to %Nat32
	store %Nat32 %35, %Nat32* %nexpc
	br label %endif_3
endif_3:
	br label %endif_2
else_2:
; if_4
	%36 = icmp eq %Word8 %1, 4
	br %Bool %36 , label %then_4, label %else_4
then_4:
	%37 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%38 = load %Nat32, %Nat32* %37
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %38, %Str8* bitcast ([18 x i8]* @.str37 to [0 x i8]*), %Nat8 %2, %Nat8 %3, %Int16 %4)
; if_5
	%39 = bitcast %Word32 %8 to %Int32
	%40 = bitcast %Word32 %12 to %Int32
	%41 = icmp slt %Int32 %39, %40
	br %Bool %41 , label %then_5, label %endif_5
then_5:
	%42 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%43 = load %Nat32, %Nat32* %42
	%44 = bitcast %Nat32 %43 to %Int32
	%45 = sext %Int16 %4 to %Int32
	%46 = add %Int32 %44, %45
	%47 = bitcast %Int32 %46 to %Nat32
	store %Nat32 %47, %Nat32* %nexpc
	br label %endif_5
endif_5:
	br label %endif_4
else_4:
; if_6
	%48 = icmp eq %Word8 %1, 5
	br %Bool %48 , label %then_6, label %else_6
then_6:
	%49 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%50 = load %Nat32, %Nat32* %49
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %50, %Str8* bitcast ([18 x i8]* @.str38 to [0 x i8]*), %Nat8 %2, %Nat8 %3, %Int16 %4)
; if_7
	%51 = bitcast %Word32 %8 to %Int32
	%52 = bitcast %Word32 %12 to %Int32
	%53 = icmp sge %Int32 %51, %52
	br %Bool %53 , label %then_7, label %endif_7
then_7:
	%54 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%55 = load %Nat32, %Nat32* %54
	%56 = bitcast %Nat32 %55 to %Int32
	%57 = sext %Int16 %4 to %Int32
	%58 = add %Int32 %56, %57
	%59 = bitcast %Int32 %58 to %Nat32
	store %Nat32 %59, %Nat32* %nexpc
	br label %endif_7
endif_7:
	br label %endif_6
else_6:
; if_8
	%60 = icmp eq %Word8 %1, 6
	br %Bool %60 , label %then_8, label %else_8
then_8:
	%61 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%62 = load %Nat32, %Nat32* %61
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %62, %Str8* bitcast ([19 x i8]* @.str39 to [0 x i8]*), %Nat8 %2, %Nat8 %3, %Int16 %4)
; if_9
	%63 = bitcast %Word32 %8 to %Nat32
	%64 = bitcast %Word32 %12 to %Nat32
	%65 = icmp ult %Nat32 %63, %64
	br %Bool %65 , label %then_9, label %endif_9
then_9:
	%66 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%67 = load %Nat32, %Nat32* %66
	%68 = bitcast %Nat32 %67 to %Int32
	%69 = sext %Int16 %4 to %Int32
	%70 = add %Int32 %68, %69
	%71 = bitcast %Int32 %70 to %Nat32
	store %Nat32 %71, %Nat32* %nexpc
	br label %endif_9
endif_9:
	br label %endif_8
else_8:
; if_10
	%72 = icmp eq %Word8 %1, 7
	br %Bool %72 , label %then_10, label %else_10
then_10:
	%73 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%74 = load %Nat32, %Nat32* %73
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %74, %Str8* bitcast ([19 x i8]* @.str40 to [0 x i8]*), %Nat8 %2, %Nat8 %3, %Int16 %4)
; if_11
	%75 = bitcast %Word32 %8 to %Nat32
	%76 = bitcast %Word32 %12 to %Nat32
	%77 = icmp uge %Nat32 %75, %76
	br %Bool %77 , label %then_11, label %endif_11
then_11:
	%78 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%79 = load %Nat32, %Nat32* %78
	%80 = bitcast %Nat32 %79 to %Int32
	%81 = sext %Int16 %4 to %Int32
	%82 = add %Int32 %80, %81
	%83 = bitcast %Int32 %82 to %Nat32
	store %Nat32 %83, %Nat32* %nexpc
	br label %endif_11
endif_11:
	br label %endif_10
else_10:
	br label %endif_10
endif_10:
	br label %endif_8
endif_8:
	br label %endif_6
endif_6:
	br label %endif_4
endif_4:
	br label %endif_2
endif_2:
	br label %endif_0
endif_0:
	%84 = load %Nat32, %Nat32* %nexpc
	ret %Nat32 %84
}

define internal void @execL(%hart_Hart* %hart, %Word32 %instr) {
	%result = alloca %Word32, align 4
	%1 = call %Word8 @decode_extractFunct3(%Word32 %instr)
	%2 = call %Word32 @decode_extractImm12(%Word32 %instr)
	%3 = call %Int32 @decode_expand12(%Word32 %2)
	%4 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%5 = call %Nat8 @decode_extractRs1(%Word32 %instr)
	%6 = call %Nat8 @decode_extractRs2(%Word32 %instr)
	%7 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%8 = zext %Nat8 %5 to %Nat32
	%9 = getelementptr [32 x %Word32], [32 x %Word32]* %7, %Int32 0, %Nat32 %8
	%10 = load %Word32, %Word32* %9
	%11 = bitcast %Word32 %10 to %Nat32
	%12 = bitcast %Int32 %3 to %Nat32
	%13 = add %Nat32 %11, %12
	store %Word32 0, %Word32* %result
; if_0
	%14 = icmp eq %Word8 %1, 0
	br %Bool %14 , label %then_0, label %else_0
then_0:
	%15 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%16 = load %Nat32, %Nat32* %15
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %16, %Str8* bitcast ([17 x i8]* @.str41 to [0 x i8]*), %Nat8 %4, %Int32 %3, %Nat8 %5)
	%17 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%18 = load %hart_BusInterface*, %hart_BusInterface** %17
	%19 = getelementptr %hart_BusInterface, %hart_BusInterface* %18, %Int32 0, %Int32 0
	%20 = load %Word32 (%Nat32, %Nat8)*, %Word32 (%Nat32, %Nat8)** %19
	%21 = call %Word32 %20(%Nat32 %13, %Nat8 1)
	store %Word32 %21, %Word32* %result
	br label %endif_0
else_0:
; if_1
	%22 = icmp eq %Word8 %1, 1
	br %Bool %22 , label %then_1, label %else_1
then_1:
	%23 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%24 = load %Nat32, %Nat32* %23
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %24, %Str8* bitcast ([17 x i8]* @.str42 to [0 x i8]*), %Nat8 %4, %Int32 %3, %Nat8 %5)
	%25 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%26 = load %hart_BusInterface*, %hart_BusInterface** %25
	%27 = getelementptr %hart_BusInterface, %hart_BusInterface* %26, %Int32 0, %Int32 0
	%28 = load %Word32 (%Nat32, %Nat8)*, %Word32 (%Nat32, %Nat8)** %27
	%29 = call %Word32 %28(%Nat32 %13, %Nat8 2)
	store %Word32 %29, %Word32* %result
	br label %endif_1
else_1:
; if_2
	%30 = icmp eq %Word8 %1, 2
	br %Bool %30 , label %then_2, label %else_2
then_2:
	%31 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%32 = load %Nat32, %Nat32* %31
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %32, %Str8* bitcast ([17 x i8]* @.str43 to [0 x i8]*), %Nat8 %4, %Int32 %3, %Nat8 %5)
	%33 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%34 = load %hart_BusInterface*, %hart_BusInterface** %33
	%35 = getelementptr %hart_BusInterface, %hart_BusInterface* %34, %Int32 0, %Int32 0
	%36 = load %Word32 (%Nat32, %Nat8)*, %Word32 (%Nat32, %Nat8)** %35
	%37 = call %Word32 %36(%Nat32 %13, %Nat8 4)
	store %Word32 %37, %Word32* %result
	br label %endif_2
else_2:
; if_3
	%38 = icmp eq %Word8 %1, 4
	br %Bool %38 , label %then_3, label %else_3
then_3:
	%39 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%40 = load %Nat32, %Nat32* %39
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %40, %Str8* bitcast ([18 x i8]* @.str44 to [0 x i8]*), %Nat8 %4, %Int32 %3, %Nat8 %5)
	%41 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%42 = load %hart_BusInterface*, %hart_BusInterface** %41
	%43 = getelementptr %hart_BusInterface, %hart_BusInterface* %42, %Int32 0, %Int32 0
	%44 = load %Word32 (%Nat32, %Nat8)*, %Word32 (%Nat32, %Nat8)** %43
	%45 = call %Word32 %44(%Nat32 %13, %Nat8 1)
	store %Word32 %45, %Word32* %result
	br label %endif_3
else_3:
; if_4
	%46 = icmp eq %Word8 %1, 5
	br %Bool %46 , label %then_4, label %endif_4
then_4:
	%47 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%48 = load %Nat32, %Nat32* %47
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %48, %Str8* bitcast ([18 x i8]* @.str45 to [0 x i8]*), %Nat8 %4, %Int32 %3, %Nat8 %5)
	%49 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%50 = load %hart_BusInterface*, %hart_BusInterface** %49
	%51 = getelementptr %hart_BusInterface, %hart_BusInterface* %50, %Int32 0, %Int32 0
	%52 = load %Word32 (%Nat32, %Nat8)*, %Word32 (%Nat32, %Nat8)** %51
	%53 = call %Word32 %52(%Nat32 %13, %Nat8 2)
	store %Word32 %53, %Word32* %result
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	%54 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%55 = zext %Nat8 %4 to %Nat32
	%56 = getelementptr [32 x %Word32], [32 x %Word32]* %54, %Int32 0, %Nat32 %55
	%57 = load %Word32, %Word32* %result
	store %Word32 %57, %Word32* %56
	ret void
}

define internal void @execS(%hart_Hart* %hart, %Word32 %instr) {
	%1 = call %Word8 @decode_extractFunct3(%Word32 %instr)
	%2 = call %Word8 @decode_extractFunct7(%Word32 %instr)
	%3 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%4 = call %Nat8 @decode_extractRs1(%Word32 %instr)
	%5 = call %Nat8 @decode_extractRs2(%Word32 %instr)
	%6 = zext %Nat8 %3 to %Word32
	%7 = zext %Word8 %2 to %Word32
	%8 = zext i8 5 to %Word32
	%9 = shl %Word32 %7, %8
	%10 = bitcast %Word32 %6 to %Word32
	%11 = or %Word32 %9, %10
	%12 = call %Int32 @decode_expand12(%Word32 %11)
	%13 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%14 = zext %Nat8 %4 to %Nat32
	%15 = getelementptr [32 x %Word32], [32 x %Word32]* %13, %Int32 0, %Nat32 %14
	%16 = load %Word32, %Word32* %15
	%17 = bitcast %Word32 %16 to %Nat32
	%18 = bitcast %Int32 %12 to %Nat32
	%19 = add %Nat32 %17, %18
	%20 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%21 = zext %Nat8 %5 to %Nat32
	%22 = getelementptr [32 x %Word32], [32 x %Word32]* %20, %Int32 0, %Nat32 %21
	%23 = load %Word32, %Word32* %22
; if_0
	%24 = icmp eq %Word8 %1, 0
	br %Bool %24 , label %then_0, label %else_0
then_0:
	%25 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%26 = load %Nat32, %Nat32* %25
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %26, %Str8* bitcast ([17 x i8]* @.str46 to [0 x i8]*), %Nat8 %5, %Int32 %12, %Nat8 %4)
	%27 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%28 = load %hart_BusInterface*, %hart_BusInterface** %27
	%29 = getelementptr %hart_BusInterface, %hart_BusInterface* %28, %Int32 0, %Int32 1
	%30 = load void (%Nat32, %Word32, %Nat8)*, void (%Nat32, %Word32, %Nat8)** %29
	call void %30(%Nat32 %19, %Word32 %23, %Nat8 1)
	br label %endif_0
else_0:
; if_1
	%31 = icmp eq %Word8 %1, 1
	br %Bool %31 , label %then_1, label %else_1
then_1:
	%32 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%33 = load %Nat32, %Nat32* %32
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %33, %Str8* bitcast ([17 x i8]* @.str47 to [0 x i8]*), %Nat8 %5, %Int32 %12, %Nat8 %4)
	%34 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%35 = load %hart_BusInterface*, %hart_BusInterface** %34
	%36 = getelementptr %hart_BusInterface, %hart_BusInterface* %35, %Int32 0, %Int32 1
	%37 = load void (%Nat32, %Word32, %Nat8)*, void (%Nat32, %Word32, %Nat8)** %36
	call void %37(%Nat32 %19, %Word32 %23, %Nat8 2)
	br label %endif_1
else_1:
; if_2
	%38 = icmp eq %Word8 %1, 2
	br %Bool %38 , label %then_2, label %endif_2
then_2:
	%39 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%40 = load %Nat32, %Nat32* %39
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %40, %Str8* bitcast ([17 x i8]* @.str48 to [0 x i8]*), %Nat8 %5, %Int32 %12, %Nat8 %4)
	%41 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 2
	%42 = load %hart_BusInterface*, %hart_BusInterface** %41
	%43 = getelementptr %hart_BusInterface, %hart_BusInterface* %42, %Int32 0, %Int32 1
	%44 = load void (%Nat32, %Word32, %Nat8)*, void (%Nat32, %Word32, %Nat8)** %43
	call void %44(%Nat32 %19, %Word32 %23, %Nat8 4)
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	ret void
}

define internal %Nat32 @execSystem(%hart_Hart* %hart, %Word32 %instr, %Nat32 %nexpc) {
	%new_mstatus = alloca %Word32, align 4
	%1 = call %Word8 @decode_extractFunct3(%Word32 %instr)
	%2 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%3 = call %Nat8 @decode_extractRs1(%Word32 %instr)
	%4 = call %Word32 @decode_extractImm12(%Word32 %instr)
	%5 = trunc %Word32 %4 to %Nat16
; if_0
	%6 = icmp eq %Word32 %instr, 115
	br %Bool %6 , label %then_0, label %else_0
then_0:
	%7 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%8 = load %Nat32, %Nat32* %7
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %8, %Str8* bitcast ([7 x i8]* @.str49 to [0 x i8]*))
	%9 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 3860)
	%10 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([17 x i8]* @.str50 to [0 x i8]*), %Word32 %9)
	%11 = call %Nat32 @trap(%hart_Hart* %hart, %Word32 8, %Nat32 %nexpc)
	ret %Nat32 %11
	br label %endif_0
else_0:
; if_1
	%13 = icmp eq %Word32 %instr, 807403635
	br %Bool %13 , label %then_1, label %else_1
then_1:
	%14 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%15 = load %Nat32, %Nat32* %14
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %15, %Str8* bitcast ([6 x i8]* @.str51 to [0 x i8]*))
	%16 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 768)
	%17 = xor %Word32 8, -1
	%18 = and %Word32 %16, %17
	%19 = or %Word32 %18, 128
	store %Word32 %19, %Word32* %new_mstatus
; if_2
	%20 = and %Word32 %16, 128
	%21 = icmp ne %Word32 %20, 0
	br %Bool %21 , label %then_2, label %endif_2
then_2:
	%22 = load %Word32, %Word32* %new_mstatus
	%23 = or %Word32 %22, 8
	store %Word32 %23, %Word32* %new_mstatus
	br label %endif_2
endif_2:
	%24 = load %Word32, %Word32* %new_mstatus
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 768, %Word32 %24)
	%25 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 833)
	%26 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 834)
	%27 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 835)
	%28 = bitcast %Word32 %25 to %Nat32
	ret %Nat32 %28
	br label %endif_1
else_1:
; if_3
	%30 = icmp eq %Word32 %instr, 1048691
	br %Bool %30 , label %then_3, label %else_3
then_3:
	%31 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%32 = load %Nat32, %Nat32* %31
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %32, %Str8* bitcast ([8 x i8]* @.str52 to [0 x i8]*))
	%33 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 3860)
	%34 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([18 x i8]* @.str53 to [0 x i8]*), %Word32 %33)
	%35 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 3
	store %Bool 1, %Bool* %35
	br label %endif_3
else_3:
; if_4
	%36 = icmp eq %Word8 %1, 1
	br %Bool %36 , label %then_4, label %else_4
then_4:
	call void @csr_rw(%hart_Hart* %hart, %Nat16 %5, %Nat8 %2, %Nat8 %3)
	br label %endif_4
else_4:
; if_5
	%37 = icmp eq %Word8 %1, 2
	br %Bool %37 , label %then_5, label %else_5
then_5:
	call void @csr_rs(%hart_Hart* %hart, %Nat16 %5, %Nat8 %2, %Nat8 %3)
	br label %endif_5
else_5:
; if_6
	%38 = icmp eq %Word8 %1, 3
	br %Bool %38 , label %then_6, label %else_6
then_6:
	call void @csr_rc(%hart_Hart* %hart, %Nat16 %5, %Nat8 %2, %Nat8 %3)
	br label %endif_6
else_6:
; if_7
	%39 = icmp eq %Word8 %1, 5
	br %Bool %39 , label %then_7, label %else_7
then_7:
	call void @csr_rwi(%hart_Hart* %hart, %Nat16 %5, %Nat8 %2, %Nat8 %3)
	br label %endif_7
else_7:
; if_8
	%40 = icmp eq %Word8 %1, 6
	br %Bool %40 , label %then_8, label %else_8
then_8:
	call void @csr_rsi(%hart_Hart* %hart, %Nat16 %5, %Nat8 %2, %Nat8 %3)
	br label %endif_8
else_8:
; if_9
	%41 = icmp eq %Word8 %1, 7
	br %Bool %41 , label %then_9, label %else_9
then_9:
	call void @csr_rci(%hart_Hart* %hart, %Nat16 %5, %Nat8 %2, %Nat8 %3)
	br label %endif_9
else_9:
	%42 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%43 = load %Nat32, %Nat32* %42
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %43, %Str8* bitcast ([34 x i8]* @.str54 to [0 x i8]*), %Word32 %instr)
	%44 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 3
	store %Bool 1, %Bool* %44
	br label %endif_9
endif_9:
	br label %endif_8
endif_8:
	br label %endif_7
endif_7:
	br label %endif_6
endif_6:
	br label %endif_5
endif_5:
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	ret %Nat32 %nexpc
}

define internal void @execFence(%hart_Hart* %hart, %Word32 %instr) {
; if_0
	%1 = icmp eq %Word32 %instr, 16777231
	br %Bool %1 , label %then_0, label %endif_0
then_0:
	%2 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 1
	%3 = load %Nat32, %Nat32* %2
	call void (%Nat32, %Str8*, ...) @trace(%Nat32 %3, %Str8* bitcast ([7 x i8]* @.str55 to [0 x i8]*))
	br label %endif_0
endif_0:
	ret void
}

define %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csrno) {
	%1 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 4
	%2 = zext %Nat16 %csrno to %Nat32
	%3 = getelementptr [4096 x %Word32], [4096 x %Word32]* %1, %Int32 0, %Nat32 %2
	%4 = load %Word32, %Word32* %3
	ret %Word32 %4
}

define void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csrno, %Word32 %value) {
	%1 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 4
	%2 = zext %Nat16 %csrno to %Nat32
	%3 = getelementptr [4096 x %Word32], [4096 x %Word32]* %1, %Int32 0, %Nat32 %2
	store %Word32 %value, %Word32* %3
	ret void
}

define internal void @csr_rw(%hart_Hart* %hart, %Nat16 %csr, %Nat8 %rd, %Nat8 %rs1) {
	%1 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%2 = zext %Nat8 %rs1 to %Nat32
	%3 = getelementptr [32 x %Word32], [32 x %Word32]* %1, %Int32 0, %Nat32 %2
	%4 = load %Word32, %Word32* %3
	%5 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%6 = zext %Nat8 %rd to %Nat32
	%7 = getelementptr [32 x %Word32], [32 x %Word32]* %5, %Int32 0, %Nat32 %6
	%8 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	store %Word32 %8, %Word32* %7
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csr, %Word32 %4)
	ret void
}

define internal void @csr_rs(%hart_Hart* %hart, %Nat16 %csr, %Nat8 %rd, %Nat8 %rs1) {
	%1 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%2 = zext %Nat8 %rs1 to %Nat32
	%3 = getelementptr [32 x %Word32], [32 x %Word32]* %1, %Int32 0, %Nat32 %2
	%4 = load %Word32, %Word32* %3
	%5 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%6 = zext %Nat8 %rd to %Nat32
	%7 = getelementptr [32 x %Word32], [32 x %Word32]* %5, %Int32 0, %Nat32 %6
	%8 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	store %Word32 %8, %Word32* %7
	%9 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	%10 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%11 = zext %Nat8 %rs1 to %Nat32
	%12 = getelementptr [32 x %Word32], [32 x %Word32]* %10, %Int32 0, %Nat32 %11
	%13 = load %Word32, %Word32* %12
	%14 = or %Word32 %9, %13
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csr, %Word32 %14)
	ret void
}

define internal void @csr_rc(%hart_Hart* %hart, %Nat16 %csr, %Nat8 %rd, %Nat8 %rs1) {
	%1 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%2 = zext %Nat8 %rs1 to %Nat32
	%3 = getelementptr [32 x %Word32], [32 x %Word32]* %1, %Int32 0, %Nat32 %2
	%4 = load %Word32, %Word32* %3
	%5 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%6 = zext %Nat8 %rd to %Nat32
	%7 = getelementptr [32 x %Word32], [32 x %Word32]* %5, %Int32 0, %Nat32 %6
	%8 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	store %Word32 %8, %Word32* %7
	%9 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	%10 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%11 = zext %Nat8 %rs1 to %Nat32
	%12 = getelementptr [32 x %Word32], [32 x %Word32]* %10, %Int32 0, %Nat32 %11
	%13 = load %Word32, %Word32* %12
	%14 = xor %Word32 %13, -1
	%15 = and %Word32 %9, %14
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csr, %Word32 %15)
	ret void
}

define internal void @csr_rwi(%hart_Hart* %hart, %Nat16 %csr, %Nat8 %rd, %Nat8 %imm) {
	%1 = zext %Nat8 %imm to %Word32
	%2 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%3 = zext %Nat8 %rd to %Nat32
	%4 = getelementptr [32 x %Word32], [32 x %Word32]* %2, %Int32 0, %Nat32 %3
	%5 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	store %Word32 %5, %Word32* %4
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csr, %Word32 %1)
	ret void
}

define internal void @csr_rsi(%hart_Hart* %hart, %Nat16 %csr, %Nat8 %rd, %Nat8 %imm) {
	%1 = zext %Nat8 %imm to %Word32
	%2 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%3 = zext %Nat8 %rd to %Nat32
	%4 = getelementptr [32 x %Word32], [32 x %Word32]* %2, %Int32 0, %Nat32 %3
	%5 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	store %Word32 %5, %Word32* %4
	%6 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	%7 = or %Word32 %6, %1
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csr, %Word32 %7)
	ret void
}

define internal void @csr_rci(%hart_Hart* %hart, %Nat16 %csr, %Nat8 %rd, %Nat8 %imm) {
	%1 = zext %Nat8 %imm to %Word32
	%2 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%3 = zext %Nat8 %rd to %Nat32
	%4 = getelementptr [32 x %Word32], [32 x %Word32]* %2, %Int32 0, %Nat32 %3
	%5 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	store %Word32 %5, %Word32* %4
	%6 = call %Word32 @hart_getCsr(%hart_Hart* %hart, %Nat16 %csr)
	%7 = xor %Word32 %1, -1
	%8 = and %Word32 %6, %7
	call void @hart_setCsr(%hart_Hart* %hart, %Nat16 %csr, %Word32 %8)
	ret void
}

define internal void @trace(%Nat32 %pc, %Str8* %form, ...) {
	%va = alloca %__VA_List, align 1
	%c = alloca %Char8, align 1
; if_0
	%1 = xor %Bool 0, 1
	br %Bool %1 , label %then_0, label %endif_0
then_0:
	ret void
	br label %endif_0
endif_0:
	%3 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_start(i8* %3)
	%4 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([8 x i8]* @.str56 to [0 x i8]*), %Nat32 %pc)
	%5 = load %__VA_List, %__VA_List* %va
	%6 = call %Int @vprintf(%Str8* %form, %__VA_List %5)
	%7 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_end(i8* %7)
	store %Char8 0, %Char8* %c
	%8 = call %Int (%ConstCharStr*, ...) @scanf(%ConstCharStr* bitcast ([3 x i8]* @.str57 to [0 x i8]*), %Char8* %c)
	ret void
}

define internal void @trace2(%Nat32 %pc, %Str8* %form, ...) {
	%va = alloca %__VA_List, align 1
	%1 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_start(i8* %1)
	%2 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([8 x i8]* @.str58 to [0 x i8]*), %Nat32 %pc)
	%3 = load %__VA_List, %__VA_List* %va
	%4 = call %Int @vprintf(%Str8* %form, %__VA_List %3)
	%5 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_end(i8* %5)
	ret void
}

define internal void @fatal(%Str8* %form, ...) {
	%va = alloca %__VA_List, align 1
	%1 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_start(i8* %1)
	%2 = load %__VA_List, %__VA_List* %va
	%3 = call %Int @vprintf(%Str8* %form, %__VA_List %2)
	%4 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_end(i8* %4)
	call void @exit(%Int -1)
	ret void
}

define internal void @notImplemented(%Str8* %form, ...) {
	%va = alloca %__VA_List, align 1
	%1 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_start(i8* %1)
	%2 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([33 x i8]* @.str59 to [0 x i8]*))
	%3 = load %__VA_List, %__VA_List* %va
	%4 = call %Int @vprintf(%Str8* %form, %__VA_List %3)
	%5 = bitcast %__VA_List* %va to i8*
	call void @llvm.va_end(i8* %5)
	%6 = call %Int @puts(%ConstCharStr* bitcast ([3 x i8]* @.str60 to [0 x i8]*))
	call void @exit(%Int -1)
	ret void
}

define void @hart_show_regs(%hart_Hart* %hart) {
	%i = alloca %Nat16, align 2
	store %Nat16 0, %Nat16* %i
; while_1
	br label %again_1
again_1:
	%1 = load %Nat16, %Nat16* %i
	%2 = icmp ult %Nat16 %1, 16
	br %Bool %2 , label %body_1, label %break_1
body_1:
	%3 = load %Nat16, %Nat16* %i
	%4 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%5 = load %Nat16, %Nat16* %i
	%6 = zext %Nat16 %5 to %Nat32
	%7 = getelementptr [32 x %Word32], [32 x %Word32]* %4, %Int32 0, %Nat32 %6
	%8 = load %Word32, %Word32* %7
	%9 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([15 x i8]* @.str61 to [0 x i8]*), %Nat16 %3, %Word32 %8)
	%10 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([5 x i8]* @.str62 to [0 x i8]*))
	%11 = load %Nat16, %Nat16* %i
	%12 = add %Nat16 %11, 16
	%13 = getelementptr %hart_Hart, %hart_Hart* %hart, %Int32 0, %Int32 0
	%14 = load %Nat16, %Nat16* %i
	%15 = add %Nat16 %14, 16
	%16 = zext %Nat16 %15 to %Nat32
	%17 = getelementptr [32 x %Word32], [32 x %Word32]* %13, %Int32 0, %Nat32 %16
	%18 = load %Word32, %Word32* %17
	%19 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([16 x i8]* @.str63 to [0 x i8]*), %Nat16 %12, %Word32 %18)
	%20 = load %Nat16, %Nat16* %i
	%21 = add %Nat16 %20, 1
	store %Nat16 %21, %Nat16* %i
	br label %again_1
break_1:
	ret void
}


