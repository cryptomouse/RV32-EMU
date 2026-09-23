
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


; MODULE: decode

; -- print includes --
; -- end print includes --
; -- print imports 'decode' --

; from import "builtin"

; end from import "builtin"
; -- end print imports 'decode' --
; -- strings --
; -- endstrings --
define %Word8 @decode_extract_op(%Word32 %instr) {
	%1 = zext i8 127 to %Word32
	%2 = and %Word32 %instr, %1
	%3 = trunc %Word32 %2 to %Word8
	ret %Word8 %3
}

define %Word8 @decode_extract_funct2(%Word32 %instr) {
	%1 = zext i8 25 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i8 3 to %Word32
	%4 = and %Word32 %2, %3
	%5 = trunc %Word32 %4 to %Word8
	ret %Word8 %5
}

define %Word8 @decode_extract_funct3(%Word32 %instr) {
	%1 = zext i8 12 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i8 7 to %Word32
	%4 = and %Word32 %2, %3
	%5 = trunc %Word32 %4 to %Word8
	ret %Word8 %5
}

define %Word8 @decode_extract_funct5(%Word32 %instr) {
	%1 = zext i8 27 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i8 31 to %Word32
	%4 = and %Word32 %2, %3
	%5 = trunc %Word32 %4 to %Word8
	ret %Word8 %5
}

define %Nat8 @decode_extract_rd(%Word32 %instr) {
	%1 = zext i8 7 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i8 31 to %Word32
	%4 = and %Word32 %2, %3
	%5 = trunc %Word32 %4 to %Nat8
	ret %Nat8 %5
}

define %Nat8 @decode_extract_rs1(%Word32 %instr) {
	%1 = zext i8 15 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i8 31 to %Word32
	%4 = and %Word32 %2, %3
	%5 = trunc %Word32 %4 to %Nat8
	ret %Nat8 %5
}

define %Nat8 @decode_extract_rs2(%Word32 %instr) {
	%1 = zext i8 20 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i8 31 to %Word32
	%4 = and %Word32 %2, %3
	%5 = trunc %Word32 %4 to %Nat8
	ret %Nat8 %5
}

define %Word8 @decode_extract_funct7(%Word32 %instr) {
	%1 = zext i8 25 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i8 127 to %Word32
	%4 = and %Word32 %2, %3
	%5 = trunc %Word32 %4 to %Word8
	ret %Word8 %5
}

define %Word32 @decode_extract_imm12(%Word32 %instr) {
	%1 = zext i8 20 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = zext i16 4095 to %Word32
	%4 = and %Word32 %2, %3
	ret %Word32 %4
}

define %Word32 @decode_extract_imm31_12(%Word32 %instr) {
	%1 = zext i8 12 to %Word32
	%2 = lshr %Word32 %instr, %1
	%3 = bitcast i32 1048575 to %Word32
	%4 = and %Word32 %2, %3
	ret %Word32 %4
}

define %Int16 @decode_extract_b_imm(%Word32 %instr) {
	%1 = call %Nat8 @decode_extract_rd(%Word32 %instr)
	%2 = zext %Nat8 %1 to %Word16
	%3 = call %Word8 @decode_extract_funct7(%Word32 %instr)
	%4 = zext i8 30 to %Word16
	%5 = and %Word16 %2, %4
	%6 = bitcast i8 63 to %Word8
	%7 = and %Word8 %3, %6
	%8 = zext %Word8 %7 to %Word16
	%9 = zext i8 5 to %Word16
	%10 = shl %Word16 %8, %9
	%11 = zext i8 1 to %Word16
	%12 = and %Word16 %2, %11
	%13 = zext i8 11 to %Word16
	%14 = shl %Word16 %12, %13
	%15 = bitcast i8 64 to %Word8
	%16 = and %Word8 %3, %15
	%17 = zext %Word8 %16 to %Word16
	%18 = zext i8 6 to %Word16
	%19 = shl %Word16 %17, %18
	%20 = alloca %Word16, align 2
	%21 = or %Word16 %19, %14
	%22 = or %Word16 %21, %10
	%23 = or %Word16 %22, %5
	store %Word16 %23, %Word16* %20
; if_0
	%24 = load %Word16, %Word16* %20
	%25 = and %Word16 %24, 4096
	%26 = zext i8 0 to %Word16
	%27 = icmp ne %Word16 %25, %26
	br %Bool %27 , label %then_0, label %endif_0
then_0:
	%28 = bitcast i16 61440 to %Word16
	%29 = load %Word16, %Word16* %20
	%30 = or %Word16 %28, %29
	store %Word16 %30, %Word16* %20
	br label %endif_0
endif_0:
	%31 = load %Word16, %Word16* %20
	%32 = bitcast %Word16 %31 to %Int16
	ret %Int16 %32
}

define %Word32 @decode_extract_jal_imm(%Word32 %instr) {
	%1 = call %Word32 @decode_extract_imm31_12(%Word32 %instr)
	%2 = zext i8 0 to %Word32
	%3 = lshr %Word32 %1, %2
	%4 = zext i8 255 to %Word32
	%5 = and %Word32 %3, %4
	%6 = zext i8 12 to %Word32
	%7 = shl %Word32 %5, %6
	%8 = zext i8 8 to %Word32
	%9 = lshr %Word32 %1, %8
	%10 = zext i8 1 to %Word32
	%11 = and %Word32 %9, %10
	%12 = zext i8 11 to %Word32
	%13 = shl %Word32 %11, %12
	%14 = zext i8 9 to %Word32
	%15 = lshr %Word32 %1, %14
	%16 = zext i16 1023 to %Word32
	%17 = and %Word32 %15, %16
	%18 = zext i8 1 to %Word32
	%19 = shl %Word32 %17, %18
	%20 = zext i8 20 to %Word32
	%21 = lshr %Word32 %1, %20
	%22 = zext i8 1 to %Word32
	%23 = and %Word32 %21, %22
	%24 = zext i8 20 to %Word32
	%25 = shl %Word32 %23, %24
	%26 = or %Word32 %25, %7
	%27 = or %Word32 %26, %13
	%28 = or %Word32 %27, %19
	ret %Word32 %28
}

define %Int32 @decode_expand12(%Word32 %val_12bit) {
; if_0
	%1 = zext i16 2048 to %Word32
	%2 = and %Word32 %val_12bit, %1
	%3 = zext i8 0 to %Word32
	%4 = icmp ne %Word32 %2, %3
	br %Bool %4 , label %then_0, label %endif_0
then_0:
	%5 = bitcast i32 4294963200 to %Word32
	%6 = or %Word32 %val_12bit, %5
	%7 = bitcast %Word32 %6 to %Int32
	ret %Int32 %7
	br label %endif_0
endif_0:
	%9 = bitcast %Word32 %val_12bit to %Int32
	ret %Int32 %9
}

define %Int32 @decode_expand20(%Word32 %val_20bit) {
; if_0
	%1 = bitcast i32 524288 to %Word32
	%2 = and %Word32 %val_20bit, %1
	%3 = zext i8 0 to %Word32
	%4 = icmp ne %Word32 %2, %3
	br %Bool %4 , label %then_0, label %endif_0
then_0:
	%5 = bitcast i32 4293918720 to %Word32
	%6 = or %Word32 %val_20bit, %5
	%7 = bitcast %Word32 %6 to %Int32
	ret %Int32 %7
	br label %endif_0
endif_0:
	%9 = bitcast %Word32 %val_20bit to %Int32
	ret %Int32 %9
}


