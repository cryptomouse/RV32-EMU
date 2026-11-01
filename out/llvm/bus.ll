
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

; from import "mmio"
declare void @mmio_write8(%Nat32 %adr, %Word8 %value)
declare void @mmio_write16(%Nat32 %adr, %Word16 %value)
declare void @mmio_write32(%Nat32 %adr, %Word32 %value)
declare %Word8 @mmio_read8(%Nat32 %adr)
declare %Word16 @mmio_read16(%Nat32 %adr)
declare %Word32 @mmio_read32(%Nat32 %adr)

; end from import "mmio"

; from import "sdl"
%SDL_Window = type opaque;
%SDL_Renderer = type {
};

%SDL_Texture = type {
};

%SDL_Rect = type {
	%Int32,
	%Int32,
	%Int32,
	%Int32
};

%SDL_Event = type {
};

declare external %Int32 @SDL_Init(%Word32 %flags)
declare external void @SDL_Quit()
declare external %ConstCharStr* @SDL_GetError()
declare external %Int32 @SDL_SetHint(%ConstCharStr* %name, %ConstCharStr* %value)
declare external void @SDL_Delay(%Nat32 %ms)
declare external %SDL_Window* @SDL_CreateWindow(%ConstCharStr* %title, %Int32 %x, %Int32 %y, %Int32 %w, %Int32 %h, %Word32 %flags)
declare external void @SDL_DestroyWindow(%SDL_Window* %window)
declare external i8* @SDL_CreateRenderer(%SDL_Window* %window, %Int32 %index, %Word32 %flags)
declare external void @SDL_DestroyRenderer(i8* %renderer)
declare external %Int32 @SDL_RenderClear(i8* %renderer)
declare external %Int32 @SDL_RenderCopy(i8* %renderer, i8* %texture, %SDL_Rect* %srcrect, %SDL_Rect* %dstrect)
declare external void @SDL_RenderPresent(i8* %renderer)
declare external i8* @SDL_CreateTexture(i8* %renderer, %Nat32 %format, %Int32 %access, %Int32 %w, %Int32 %h)
declare external void @SDL_DestroyTexture(i8* %texture)
declare external %Int32 @SDL_UpdateTexture(i8* %texture, %SDL_Rect* %rect, i8* %pixels, %Int32 %pitch)
declare external %Int32 @SDL_PollEvent(i8* %event)

; end from import "sdl"

; from import "display"
%display_MemMap = type i8* (%Nat32, %Nat32)*;
%display_Device = type {
	%Word32 (%display_Device*, %Nat32)*,
	void (%display_Device*, %Nat32, %Word32)*,
	%Word32,
	%Word32,
	%Word32,
	%Nat32,
	%Nat32,
	%Nat32,
	%Nat32,
	%display_MemMap,
	%Nat32,
	%Nat32,
	%Bool,
	%SDL_Window*,
	i8*,
	i8*
};

declare void @display_init(%display_Device* %dev, %display_MemMap %mm)
declare %Bool @display_isOn(%display_Device* %dev)
declare void @display_poll(%display_Device* %dev)
declare void @display_waitClose(%display_Device* %dev)
declare void @display_deinit(%display_Device* %dev)

; end from import "display"
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
%bus_ReadInterface = type %Word32 (%Nat32, %Nat8);
%bus_WriteInterface = type void (%Nat32, %Word32, %Nat8);
%bus_IrqInterface = type void ();
%bus_Interface = type {
	%bus_ReadInterface*,
	%bus_WriteInterface*,
	%bus_IrqInterface*
};

%bus_Connector = type %Bool (%bus_Interface*);
@ram = internal global [8388608 x %Word8] zeroinitializer
@rom = internal global [1048576 x %Word8] zeroinitializer
@displays = internal global [1 x %display_Device] zeroinitializer
define void @bus_init() {
	%1 = getelementptr [1 x %display_Device], [1 x %display_Device]* @displays, %Int32 0, %Int32 0
	call void @display_init(%display_Device* %1, i8* (%Nat32, %Nat32)* @bus_ramPtr)
	ret void
}

define void @bus_deinit() {
	%1 = getelementptr [1 x %display_Device], [1 x %display_Device]* @displays, %Int32 0, %Int32 0
	call void @display_deinit(%display_Device* %1)
	ret void
}

define void @bus_poll() {
	%1 = getelementptr [1 x %display_Device], [1 x %display_Device]* @displays, %Int32 0, %Int32 0
	call void @display_poll(%display_Device* %1)
	ret void
}

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
	%18 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 4026535936, 0
	%19 = insertvalue {%Nat32,%Nat32} %18, %Nat32 4026540032, 1
	%20 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %19)
	br %Bool %20 , label %then_2, label %else_2
then_2:
; if_3
	%21 = icmp eq %Nat8 %size, 4
	br %Bool %21 , label %then_3, label %endif_3
then_3:
	%22 = getelementptr [1 x %display_Device], [1 x %display_Device]* @displays, %Int32 0, %Int32 0
	%23 = sub %Nat32 %adr, 4026535936
	%24 = getelementptr [1 x %display_Device], [1 x %display_Device]* @displays, %Int32 0, %Int32 0
	%25 = getelementptr %display_Device, %display_Device* %24, %Int32 0, %Int32 0
	%26 = load %Word32 (%display_Device*, %Nat32)*, %Word32 (%display_Device*, %Nat32)** %25
	%27 = call %Word32 %26(%display_Device* %22, %Nat32 %23)
	ret %Word32 %27
	br label %endif_3
endif_3:
	br label %endif_2
else_2:
; if_4
	%29 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 4026531840, 0
	%30 = insertvalue {%Nat32,%Nat32} %29, %Nat32 4043309056, 1
	%31 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %30)
	br %Bool %31 , label %then_4, label %else_4
then_4:
	%32 = sub %Nat32 %adr, 4026531840
; if_5
	%33 = icmp eq %Nat8 %size, 1
	br %Bool %33 , label %then_5, label %else_5
then_5:
	%34 = call %Word8 @mmio_read8(%Nat32 %32)
	%35 = zext %Word8 %34 to %Word32
	ret %Word32 %35
	br label %endif_5
else_5:
; if_6
	%37 = icmp eq %Nat8 %size, 2
	br %Bool %37 , label %then_6, label %else_6
then_6:
	%38 = call %Word16 @mmio_read16(%Nat32 %32)
	%39 = zext %Word16 %38 to %Word32
	ret %Word32 %39
	br label %endif_6
else_6:
; if_7
	%41 = icmp eq %Nat8 %size, 4
	br %Bool %41 , label %then_7, label %endif_7
then_7:
	%42 = call %Word32 @mmio_read32(%Nat32 %32)
	ret %Word32 %42
	br label %endif_7
endif_7:
	br label %endif_6
endif_6:
	br label %endif_5
endif_5:
	br label %endif_4
else_4:
	call void @bus_memoryViolation(%Char8 114, %Nat32 %adr)
	br label %endif_4
endif_4:
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	ret %Word32 0
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
	%8 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 4026535936, 0
	%9 = insertvalue {%Nat32,%Nat32} %8, %Nat32 4026540032, 1
	%10 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %9)
	br %Bool %10 , label %then_1, label %else_1
then_1:
; if_2
	%11 = icmp eq %Nat8 %size, 4
	br %Bool %11 , label %then_2, label %endif_2
then_2:
	%12 = getelementptr [1 x %display_Device], [1 x %display_Device]* @displays, %Int32 0, %Int32 0
	%13 = sub %Nat32 %adr, 4026535936
	%14 = getelementptr [1 x %display_Device], [1 x %display_Device]* @displays, %Int32 0, %Int32 0
	%15 = getelementptr %display_Device, %display_Device* %14, %Int32 0, %Int32 1
	%16 = load void (%display_Device*, %Nat32, %Word32)*, void (%display_Device*, %Nat32, %Word32)** %15
	call void %16(%display_Device* %12, %Nat32 %13, %Word32 %value)
	br label %endif_2
endif_2:
	br label %endif_1
else_1:
; if_3
	%17 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 4026531840, 0
	%18 = insertvalue {%Nat32,%Nat32} %17, %Nat32 4043309056, 1
	%19 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %18)
	br %Bool %19 , label %then_3, label %else_3
then_3:
	%20 = sub %Nat32 %adr, 4026531840
; if_4
	%21 = icmp eq %Nat8 %size, 1
	br %Bool %21 , label %then_4, label %else_4
then_4:
	%22 = trunc %Word32 %value to %Word8
	call void @mmio_write8(%Nat32 %20, %Word8 %22)
	br label %endif_4
else_4:
; if_5
	%23 = icmp eq %Nat8 %size, 2
	br %Bool %23 , label %then_5, label %else_5
then_5:
	%24 = trunc %Word32 %value to %Word16
	call void @mmio_write16(%Nat32 %20, %Word16 %24)
	br label %endif_5
else_5:
; if_6
	%25 = icmp eq %Nat8 %size, 4
	br %Bool %25 , label %then_6, label %endif_6
then_6:
	call void @mmio_write32(%Nat32 %20, %Word32 %value)
	br label %endif_6
endif_6:
	br label %endif_5
endif_5:
	br label %endif_4
endif_4:
	br label %endif_3
else_3:
; if_7
	%26 = insertvalue {%Nat32,%Nat32} zeroinitializer, %Nat32 1048576, 1
	%27 = call %Bool @isAdressInRegion(%Nat32 %adr, {%Nat32,%Nat32} %26)
	br %Bool %27 , label %then_7, label %else_7
then_7:
	call void @bus_memoryViolation(%Char8 119, %Nat32 %adr)
	br label %endif_7
else_7:
	call void @bus_memoryViolation(%Char8 119, %Nat32 %adr)
	br label %endif_7
endif_7:
	br label %endif_3
endif_3:
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
	ret %Word32 0
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
	%i = alloca %SizeT, align 8
	%1 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([10 x i8]* @.str2 to [0 x i8]*), %Str8* %filename)
	%2 = call %FILE* @fopen(%Str8* %filename, %ConstCharStr* bitcast ([3 x i8]* @.str3 to [0 x i8]*))
; if_0
	%3 = icmp eq %FILE* %2, null
	br %Bool %3 , label %then_0, label %endif_0
then_0:
	%4 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([29 x i8]* @.str4 to [0 x i8]*), %Str8* %filename)
	ret %Nat32 0
	br label %endif_0
endif_0:
	%6 = bitcast [0 x %Word8]* %bufptr to i8*
	%7 = zext %Nat32 %buf_size to %SizeT
	%8 = call %SizeT @fread(i8* %6, %SizeT 1, %SizeT %7, %FILE* %2)
	%9 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([19 x i8]* @.str5 to [0 x i8]*), %SizeT %8)
; if_1
	br %Bool 0 , label %then_1, label %endif_1
then_1:
	store %SizeT 0, %SizeT* %i
; while_1
	br label %again_1
again_1:
	%10 = udiv %SizeT %8, 4
	%11 = load %SizeT, %SizeT* %i
	%12 = icmp ult %SizeT %11, %10
	br %Bool %12 , label %body_1, label %break_1
body_1:
	%13 = load %SizeT, %SizeT* %i
	%14 = bitcast [0 x %Word8]* %bufptr to [0 x %Nat32]*
	%15 = load %SizeT, %SizeT* %i
	%16 = trunc %SizeT %15 to %Nat32
	%17 = getelementptr [0 x %Nat32], [0 x %Nat32]* %14, %Int32 0, %Nat32 %16
	%18 = load %Nat32, %Nat32* %17
	%19 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([15 x i8]* @.str6 to [0 x i8]*), %SizeT %13, %Nat32 %18)
	%20 = load %SizeT, %SizeT* %i
	%21 = add %SizeT %20, 4
	store %SizeT %21, %SizeT* %i
	br label %again_1
break_1:
	%22 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([13 x i8]* @.str7 to [0 x i8]*))
	br label %endif_1
endif_1:
	%23 = call %Int @fclose(%FILE* %2)
	%24 = trunc %SizeT %8 to %Nat32
	ret %Nat32 %24
}

define void @bus_show_ram() {
	%i = alloca %Nat32, align 4
	%j = alloca %Nat32, align 4
	store %Nat32 0, %Nat32* %i
; while_1
	br label %again_1
again_1:
	%1 = load %Nat32, %Nat32* %i
	%2 = icmp ult %Nat32 %1, 256
	br %Bool %2 , label %body_1, label %break_1
body_1:
	%3 = load %Nat32, %Nat32* %i
	%4 = mul %Nat32 %3, 16
	%5 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([5 x i8]* @.str8 to [0 x i8]*), %Nat32 %4)
	store %Nat32 0, %Nat32* %j
; while_2
	br label %again_2
again_2:
	%6 = load %Nat32, %Nat32* %j
	%7 = icmp ult %Nat32 %6, 16
	br %Bool %7 , label %body_2, label %break_2
body_2:
	%8 = load %Nat32, %Nat32* %i
	%9 = load %Nat32, %Nat32* %j
	%10 = add %Nat32 %8, %9
	%11 = bitcast %Nat32 %10 to %Nat32
	%12 = getelementptr [8388608 x %Word8], [8388608 x %Word8]* @ram, %Int32 0, %Nat32 %11
	%13 = load %Word8, %Word8* %12
	%14 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([6 x i8]* @.str9 to [0 x i8]*), %Word8 %13)
	%15 = load %Nat32, %Nat32* %j
	%16 = add %Nat32 %15, 1
	store %Nat32 %16, %Nat32* %j
	br label %again_2
break_2:
	%17 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([2 x i8]* @.str10 to [0 x i8]*))
	%18 = load %Nat32, %Nat32* %i
	%19 = add %Nat32 %18, 16
	store %Nat32 %19, %Nat32* %i
	br label %again_1
break_1:
	ret void
}


