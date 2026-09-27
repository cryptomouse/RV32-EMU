
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


; MODULE: bits32

; -- print includes --
; -- end print includes --
; -- print imports 'bits32' --

; from import "builtin"

; end from import "builtin"
; -- end print imports 'bits32' --
; -- strings --
; -- endstrings --
define %Word32 @bits32_bitmask(%Nat8 %len) alwaysinline {
	%1 = zext i8 1 to %Word32
	%2 = zext %Nat8 %len to %Word32
	%3 = shl %Word32 %1, %2
	%4 = bitcast %Word32 %3 to %Nat32
	%5 = sub %Nat32 %4, 1
	%6 = bitcast %Nat32 %5 to %Word32
	ret %Word32 %6
}

define %Word32 @bits32_extract(%Word32 %value, %Nat8 %pos, %Nat8 %len) alwaysinline {
	%1 = zext %Nat8 %pos to %Word32
	%2 = lshr %Word32 %value, %1
	%3 = call %Word32 @bits32_bitmask(%Nat8 %len)
	%4 = and %Word32 %2, %3
	ret %Word32 %4
}

define %Word32 @bits32_insert(%Word32 %value, %Word32 %bitfield, %Nat8 %pos, %Nat8 %len) alwaysinline {
	%1 = call %Word32 @bits32_bitmask(%Nat8 %len)
	%2 = zext %Nat8 %pos to %Word32
	%3 = shl %Word32 %1, %2
	%4 = xor %Word32 %3, -1
	%5 = and %Word32 %value, %4
	%6 = call %Word32 @bits32_bitmask(%Nat8 %len)
	%7 = and %Word32 %bitfield, %6
	%8 = zext %Nat8 %pos to %Word32
	%9 = shl %Word32 %7, %8
	%10 = or %Word32 %5, %9
	ret %Word32 %10
}

define %Word32 @bits32_set(%Word32 %x, %Nat8 %no) alwaysinline {
	%1 = zext i8 1 to %Word32
	%2 = zext %Nat8 %no to %Word32
	%3 = shl %Word32 %1, %2
	%4 = or %Word32 %x, %3
	ret %Word32 %4
}

define %Word32 @bits32_reset(%Word32 %x, %Nat8 %no) alwaysinline {
	%1 = zext i8 1 to %Word32
	%2 = zext %Nat8 %no to %Word32
	%3 = shl %Word32 %1, %2
	%4 = xor %Word32 %3, -1
	%5 = and %Word32 %x, %4
	ret %Word32 %5
}

define %Word32 @bits32_switch(%Word32 %x, %Nat8 %no, %Bool %val) alwaysinline {
; if_0
	br %Bool %val , label %then_0, label %else_0
then_0:
	%1 = call %Word32 @bits32_set(%Word32 %x, %Nat8 %no)
	ret %Word32 %1
	br label %endif_0
else_0:
	%3 = call %Word32 @bits32_reset(%Word32 %x, %Nat8 %no)
	ret %Word32 %3
	br label %endif_0
endif_0:
	%5 = zext i8 0 to %Word32
	ret %Word32 %5
}

define %Bool @bits32_check(%Word32 %x, %Nat8 %no) alwaysinline {
	%1 = zext i8 1 to %Word32
	%2 = zext %Nat8 %no to %Word32
	%3 = shl %Word32 %1, %2
	%4 = and %Word32 %x, %3
	%5 = zext i8 0 to %Word32
	%6 = icmp ne %Word32 %4, %5
	ret %Bool %6
}


