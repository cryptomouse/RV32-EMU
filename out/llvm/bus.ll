
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


; MODULE: bus

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
; -- end print includes --
; -- print imports 'bus' --

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
; -- end print imports 'bus' --
; -- strings --
@.str1 = private constant [38 x i8] [i8 42, i8 42, i8 42, i8 32, i8 77, i8 69, i8 77, i8 79, i8 82, i8 89, i8 32, i8 86, i8 73, i8 79, i8 76, i8 65, i8 84, i8 73, i8 79, i8 78, i8 32, i8 39, i8 37, i8 99, i8 39, i8 32, i8 48, i8 120, i8 37, i8 48, i8 56, i8 120, i8 32, i8 42, i8 42, i8 42, i8 10, i8 0]
@.str2 = private constant [10 x i8] [i8 76, i8 79, i8 65, i8 68, i8 58, i8 32, i8 37, i8 115, i8 10, i8 0]
@.str3 = private constant [3 x i8] [i8 114, i8 98, i8 0]
@.str4 = private constant [29 x i8] [i8 101, i8 114, i8 114, i8 111, i8 114, i8 58, i8 32, i8 99, i8 97, i8 110, i8 110, i8 111, i8 116, i8 32, i8 111, i8 112, i8 101, i8 110, i8 32, i8 102, i8 105, i8 108, i8 101, i8 32, i8 39, i8 37, i8 115, i8 39, i8 0]
@.str5 = private constant [19 x i8] [i8 76, i8 79, i8 65, i8 68, i8 69, i8 68, i8 58, i8 32, i8 37, i8 122, i8 117, i8 32, i8 98, i8 121, i8 116, i8 101, i8 115, i8 10, i8 0]
@.str6 = private constant [15 x i8] [i8 37, i8 48, i8 56, i8 122, i8 120, i8 58, i8 32, i8 48, i8 120, i8 37, i8 48, i8 56, i8 120, i8 10, i8 0]
@.str7 = private constant [13 x i8] [i8 45, i8 45, i8 45, i8 45, i8 45, i8 45, i8 45, i8 45, i8 45, i8 45, i8 45, i8 10, i8 0]
@.str8 = private constant [5 x i8] [i8 37, i8 48, i8 56, i8 88, i8 0]
@.str9 = private constant [6 x i8] [i8 32, i8 37, i8 48, i8 50, i8 88, i8 0]
@.str10 = private constant [2 x i8] [i8 10, i8 0]
; -- endstrings --
@ram = internal global [8388608 x %Word8] zeroinitializer
@rom = internal global [1048576 x %Word8] zeroinitializer
define %Word32 @bus_read(%Nat32 %adr, %Nat8 %size) {
; if_0
	%1 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 268435456, 0
	%2 = insertvalue {%Nat32,%Nat32} %1, %Nat32 276824064, 1
	%3 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %2)
	br %Bool %3 , label %then_0, label %else_0
then_0:
	%4 = sub %Nat32 %adr, 268435456
	%5 = bitcast %Nat32 %4 to %Nat32
	%6 = getelementptr [8388608 x %Word8], [8388608 x %Word8]* @ram, %Int32 0, %Nat32 %5
	%7 = bitcast %Word8* %6 to i8*
	%8 = call %Word32 @readFrom(i8* %7, %Nat32 %adr, %Nat8 %size)
	ret %Word32 %8
	br label %endif_0
else_0:
; if_1
	%10 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 1048576, 1
	%11 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %10)
	br %Bool %11 , label %then_1, label %else_1
then_1:
	%12 = sub %Nat32 %adr, 0
	%13 = bitcast %Nat32 %12 to %Nat32
	%14 = getelementptr [1048576 x %Word8], [1048576 x %Word8]* @rom, %Int32 0, %Nat32 %13
	%15 = bitcast %Word8* %14 to i8*
	%16 = call %Word32 @readFrom(i8* %15, %Nat32 %adr, %Nat8 %size)
	ret %Word32 %16
	br label %endif_1
else_1:
; if_2
	%18 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 4026531840, 0
	%19 = insertvalue {%Nat32,%Nat32} %18, %Nat32 4043309056, 1
	%20 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %19)
	br %Bool %20 , label %then_2, label %else_2
then_2:
	%21 = sub %Nat32 %adr, 4026531840
; if_3
	%22 = icmp eq %Nat8 %size, 1
	br %Bool %22 , label %then_3, label %else_3
then_3:
	%23 = call %Word8 @mmio_read8(%Nat32 %21)
	%24 = zext %Word8 %23 to %Word32
	ret %Word32 %24
	br label %endif_3
else_3:
; if_4
	%26 = icmp eq %Nat8 %size, 2
	br %Bool %26 , label %then_4, label %else_4
then_4:
	%27 = call %Word16 @mmio_read16(%Nat32 %21)
	%28 = zext %Word16 %27 to %Word32
	ret %Word32 %28
	br label %endif_4
else_4:
; if_5
	%30 = icmp eq %Nat8 %size, 4
	br %Bool %30 , label %then_5, label %endif_5
then_5:
	%31 = call %Word32 @mmio_read32(%Nat32 %21)
	ret %Word32 %31
	br label %endif_5
endif_5:
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_2
else_2:
	call void @bus_memoryViolation(%Char8 114, %Nat32 %adr)
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	%33 = zext i8 0 to %Word32
	ret %Word32 %33
}

define void @bus_write(%Nat32 %adr, %Word32 %value, %Nat8 %size) {
; if_0
	%1 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 268435456, 0
	%2 = insertvalue {%Nat32,%Nat32} %1, %Nat32 276824064, 1
	%3 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %2)
	br %Bool %3 , label %then_0, label %else_0
then_0:
	%4 = sub %Nat32 %adr, 268435456
	%5 = bitcast %Nat32 %4 to %Nat32
	%6 = getelementptr [8388608 x %Word8], [8388608 x %Word8]* @ram, %Int32 0, %Nat32 %5
	%7 = bitcast %Word8* %6 to i8*
	call void @writeTo(i8* %7, %Nat32 %adr, %Word32 %value, %Nat8 %size)
	br label %endif_0
else_0:
; if_1
	%8 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 4026531840, 0
	%9 = insertvalue {%Nat32,%Nat32} %8, %Nat32 4043309056, 1
	%10 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %9)
	br %Bool %10 , label %then_1, label %else_1
then_1:
	%11 = sub %Nat32 %adr, 4026531840
; if_2
	%12 = icmp eq %Nat8 %size, 1
	br %Bool %12 , label %then_2, label %else_2
then_2:
	%13 = trunc %Word32 %value to %Word8
	call void @mmio_write8(%Nat32 %11, %Word8 %13)
	br label %endif_2
else_2:
; if_3
	%14 = icmp eq %Nat8 %size, 2
	br %Bool %14 , label %then_3, label %else_3
then_3:
	%15 = trunc %Word32 %value to %Word16
	call void @mmio_write16(%Nat32 %11, %Word16 %15)
	br label %endif_3
else_3:
; if_4
	%16 = icmp eq %Nat8 %size, 4
	br %Bool %16 , label %then_4, label %endif_4
then_4:
	call void @mmio_write32(%Nat32 %11, %Word32 %value)
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_2
endif_2:
	br label %endif_1
else_1:
; if_5
	%17 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 1048576, 1
	%18 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %17)
	br %Bool %18 , label %then_5, label %else_5
then_5:
	call void @bus_memoryViolation(%Char8 119, %Nat32 %adr)
	br label %endif_5
else_5:
	call void @bus_memoryViolation(%Char8 119, %Nat32 %adr)
	br label %endif_5
endif_5:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	ret void
}

define internal %Word32 @readFrom(i8* %ptr, %Nat32 %adr, %Nat8 %size) {
; if_0
	%1 = icmp eq %Nat8 %size, 1
	br %Bool %1 , label %then_0, label %else_0
then_0:
	%2 = bitcast i8* %ptr to %Word8*
	%3 = load %Word8, %Word8* %2
	%4 = zext %Word8 %3 to %Word32
	ret %Word32 %4
	br label %endif_0
else_0:
; if_1
	%6 = icmp eq %Nat8 %size, 2
	br %Bool %6 , label %then_1, label %else_1
then_1:
	%7 = bitcast i8* %ptr to %Word16*
	%8 = load %Word16, %Word16* %7
	%9 = zext %Word16 %8 to %Word32
	ret %Word32 %9
	br label %endif_1
else_1:
; if_2
	%11 = icmp eq %Nat8 %size, 4
	br %Bool %11 , label %then_2, label %endif_2
then_2:
	%12 = bitcast i8* %ptr to %Word32*
	%13 = load %Word32, %Word32* %12
	ret %Word32 %13
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	%15 = zext i8 0 to %Word32
	ret %Word32 %15
}

define internal void @writeTo(i8* %ptr, %Nat32 %adr, %Word32 %value, %Nat8 %size) {
; if_0
	%1 = icmp eq %Nat8 %size, 1
	br %Bool %1 , label %then_0, label %else_0
then_0:
	%2 = bitcast i8* %ptr to %Word8*
	%3 = trunc %Word32 %value to %Word8
	store %Word8 %3, %Word8* %2
	br label %endif_0
else_0:
; if_1
	%4 = icmp eq %Nat8 %size, 2
	br %Bool %4 , label %then_1, label %else_1
then_1:
	%5 = bitcast i8* %ptr to %Word16*
	%6 = trunc %Word32 %value to %Word16
	store %Word16 %6, %Word16* %5
	br label %endif_1
else_1:
; if_2
	%7 = icmp eq %Nat8 %size, 4
	br %Bool %7 , label %then_2, label %endif_2
then_2:
	%8 = bitcast i8* %ptr to %Word32*
	store %Word32 %value, %Word32* %8
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	ret void
}

define i8* @bus_ramPtr(%Nat32 %adr, %Nat32 %size) {
; if_0
	%1 = icmp ult %Nat32 %adr, 268435456
	%2 = icmp uge %Nat32 %adr, 276824064
	%3 = or %Bool %1, %2
	%4 = sub %Nat32 276824064, %adr
	%5 = icmp ugt %Nat32 %size, %4
	%6 = or %Bool %3, %5
	br %Bool %6 , label %then_0, label %endif_0
then_0:
	ret i8* null
	br label %endif_0
endif_0:
	%8 = sub %Nat32 %adr, 268435456
	%9 = bitcast %Nat32 %8 to %Nat32
	%10 = getelementptr [8388608 x %Word8], [8388608 x %Word8]* @ram, %Int32 0, %Nat32 %9
	%11 = bitcast %Word8* %10 to i8*
	ret i8* %11
}

define internal %Bool @isAdressInRegion(%Nat32 %x, {%Nat32,%Nat32} %__region) alwaysinline {
	%region = alloca {%Nat32,%Nat32}
	store {%Nat32,%Nat32} %__region, {%Nat32,%Nat32}* %region
	%1 = getelementptr {%Nat32,%Nat32}, {%Nat32,%Nat32}* %region, %Int32 0, %Int32 0
	%2 = load %Nat32, %Nat32* %1
	%3 = icmp uge %Nat32 %x, %2
	%4 = getelementptr {%Nat32,%Nat32}, {%Nat32,%Nat32}* %region, %Int32 0, %Int32 1
	%5 = load %Nat32, %Nat32* %4
	%6 = icmp ult %Nat32 %x, %5
	%7 = and %Bool %3, %6
	ret %Bool %7
}

@memviolationCnt = internal global %Nat32 0
define void @bus_memoryViolation(%Char8 %rw, %Nat32 %adr) {
	%1 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([38 x i8]* @.str1 to [0 x i8]*), %Char8 %rw, %Nat32 %adr)
; if_0
	%2 = load %Nat32, %Nat32* @memviolationCnt
	%3 = icmp ugt %Nat32 %2, 10
	br %Bool %3 , label %then_0, label %endif_0
then_0:
	call void @exit(%Int 1)
	br label %endif_0
endif_0:
	%4 = load %Nat32, %Nat32* @memviolationCnt
	%5 = add %Nat32 %4, 1
	store %Nat32 %5, %Nat32* @memviolationCnt
	ret void
}

define %Nat32 @bus_load_rom(%Str8* %filename) {
	%1 = bitcast [1048576 x %Word8]* @rom to [0 x %Word8]*
	%2 = call %Nat32 @load(%Str8* %filename, [0 x %Word8]* %1, %Nat32 1048576)
	ret %Nat32 %2
}

define internal %Nat32 @load(%Str8* %filename, [0 x %Word8]* %bufptr, %Nat32 %buf_size) {
	%1 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([10 x i8]* @.str2 to [0 x i8]*), %Str8* %filename)
	%2 = call i8* @fopen(%Str8* %filename, %ConstCharStr* bitcast ([3 x i8]* @.str3 to [0 x i8]*))
; if_0
	%3 = icmp eq i8* %2, null
	br %Bool %3 , label %then_0, label %endif_0
then_0:
	%4 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([29 x i8]* @.str4 to [0 x i8]*), %Str8* %filename)
	ret %Nat32 0
	br label %endif_0
endif_0:
	%6 = bitcast [0 x %Word8]* %bufptr to i8*
	%7 = zext %Nat32 %buf_size to %SizeT
	%8 = call %SizeT @fread(i8* %6, %SizeT 1, %SizeT %7, i8* %2)
	%9 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([19 x i8]* @.str5 to [0 x i8]*), %SizeT %8)
; if_1
	br %Bool 0 , label %then_1, label %endif_1
then_1:
	%10 = alloca %SizeT, align 8
	store %SizeT 0, %SizeT* %10
; while_1
	br label %again_1
again_1:
	%11 = udiv %SizeT %8, 4
	%12 = load %SizeT, %SizeT* %10
	%13 = icmp ult %SizeT %12, %11
	br %Bool %13 , label %body_1, label %break_1
body_1:
	%14 = load %SizeT, %SizeT* %10
	%15 = load %SizeT, %SizeT* %10
	%16 = bitcast [0 x %Word8]* %bufptr to [0 x %Nat32]*
	%17 = trunc %SizeT %15 to %Nat32
	%18 = getelementptr [0 x %Nat32], [0 x %Nat32]* %16, %Int32 0, %Nat32 %17
	%19 = load %Nat32, %Nat32* %18
	%20 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([15 x i8]* @.str6 to [0 x i8]*), %SizeT %14, %Nat32 %19)
	%21 = load %SizeT, %SizeT* %10
	%22 = add %SizeT %21, 4
	store %SizeT %22, %SizeT* %10
	br label %again_1
break_1:
	%23 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([13 x i8]* @.str7 to [0 x i8]*))
	br label %endif_1
endif_1:
	%24 = call %Int @fclose(i8* %2)
	%25 = trunc %SizeT %8 to %Nat32
	ret %Nat32 %25
}

define void @bus_show_ram() {
	%1 = alloca %Nat32, align 4
	store %Nat32 0, %Nat32* %1
; while_1
	br label %again_1
again_1:
	%2 = load %Nat32, %Nat32* %1
	%3 = icmp ult %Nat32 %2, 256
	br %Bool %3 , label %body_1, label %break_1
body_1:
	%4 = load %Nat32, %Nat32* %1
	%5 = mul %Nat32 %4, 16
	%6 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([5 x i8]* @.str8 to [0 x i8]*), %Nat32 %5)
	%7 = alloca %Nat32, align 4
	store %Nat32 0, %Nat32* %7
; while_2
	br label %again_2
again_2:
	%8 = load %Nat32, %Nat32* %7
	%9 = icmp ult %Nat32 %8, 16
	br %Bool %9 , label %body_2, label %break_2
body_2:
	%10 = load %Nat32, %Nat32* %1
	%11 = load %Nat32, %Nat32* %7
	%12 = add %Nat32 %10, %11
	%13 = bitcast %Nat32 %12 to %Nat32
	%14 = getelementptr [8388608 x %Word8], [8388608 x %Word8]* @ram, %Int32 0, %Nat32 %13
	%15 = load %Word8, %Word8* %14
	%16 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([6 x i8]* @.str9 to [0 x i8]*), %Word8 %15)
	%17 = load %Nat32, %Nat32* %7
	%18 = add %Nat32 %17, 1
	store %Nat32 %18, %Nat32* %7
	br label %again_2
break_2:
	%19 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([2 x i8]* @.str10 to [0 x i8]*))
	%20 = load %Nat32, %Nat32* %1
	%21 = add %Nat32 %20, 16
	store %Nat32 %21, %Nat32* %1
	br label %again_1
break_1:
	ret void
}


