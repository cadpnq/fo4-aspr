ScriptName ASPr:lib:Binlib
import Math

; Why bother defining these? We need to call them by name later
bool Function LogicalAND(bool Val1, bool Val2) Global
	Return Val1 && Val2
EndFunction

bool Function LogicalNAND(bool Val1, bool Val2) Global
	Return !(Val1 && Val2)
EndFunction

bool Function LogicalOR(bool Val1, bool Val2) Global
	Return Val1 || Val2
EndFunction

bool Function LogicalNOR(bool Val1, bool Val2) Global
	Return !(Val1 || Val2)
EndFunction

bool Function LogicalXOR(bool Val1, bool Val2) Global
	Return (!Val1 && Val2) || (Val1 && !Val2)
EndFunction

bool Function LogicalXNOR(bool Val1, bool Val2) Global
	Return !((!Val1 && Val2) || (Val1 && !Val2))
EndFunction

bool Function LogicalNOT(bool Val1) Global
	Return !Val1
EndFunction

int Function RightShift(int Val, int Amt) Global
	return Val / Math.pow(2, Amt) as int
EndFunction

int Function LeftShift(int Val, int Amt) Global
	return Val * Math.pow(2, Amt) as int
EndFunction

int Function GetBit(int Val, int Bit) Global
	return Math.floor(Val / Math.pow(2, bit)) % 2
EndFunction

int Function SetBit(int Val, int Bit, int BitState) Global
	If(GetBit(Val, Bit) == BitState)
		return Val
	EndIf

	int i = Pow(2, Bit) as int
	If(!BitState)
		i = -i
	EndIf

	return Val + i
EndFunction

;bool[] Function IntToArray(int val) Global
;	bool[] ReturnValue = new bool[32]
;
;	int i = 0
;	While(i < 32)
;		ReturnValue[i] = (GetBit(val, i) == 1)
;
;		i += 1
;	EndWhile
;
;	return ReturnValue
;EndFunction

bool[] Function IntToArray(int val) Global
	bool[] ReturnValue = new bool[32]

	int x = val
	If (val < 0)
		x -= 2147483647
		x -= 1
		ReturnValue[31] = True
	EndIf
	int i = 0
	While(i < 31)
		ReturnValue[i] = Math.abs(Math.floor(x % 2)) == 1
		x = x / 2

		i += 1
	EndWhile

	return ReturnValue
EndFunction

;int Function ArrayToInt(bool[] val) Global
;	int ReturnValue = 0
;
;	int i = 0
;	While(i < 32)
;		ReturnValue = SetBit(ReturnValue, i, val[i] as int)
;
;		i += 1
;	EndWhile
;
;	return ReturnValue
;EndFunction

int Function ArrayToInt(bool[] val) Global
	int ReturnValue = 0

	If (val[31])
		ReturnValue = -2147483647
	EndIf

	int x = 1
	int i = 0
	While(i < 31)
		If(val[i])
			ReturnValue += x
		EndIf
		x += x
		i += 1
	EndWhile

	If (val[31])
		ReturnValue -= 1
	EndIf

	Return ReturnValue
EndFunction

; The docs say that using CallFunction is slower than a real function call
; so if a speedup is ever needed this is a good place to start
; =======
; It was indeed a good place to start. Inlining this code into ABitwise*
; took us from ~1000-1200ms to ~5ms
bool[] Function ApplyABitwise(string Fname, bool[] A, bool[] B) Global
	bool[] ReturnValue = new bool[32]
	var[] Args = new var[2]

	Binlib bl

	int i = 0
	While(i < 32)
		Args[0] = A[i]
		Args[1] = B[i]
		ReturnValue[i] = Utility.CallGlobalFunction("Binlib", Fname, Args)

		i += 1
	EndWhile

	return ReturnValue
EndFunction

bool[] Function ABitwiseAND(bool[] A, bool[] B) Global
	bool[] ReturnValue = new bool[32]

	int i = 0
	While(i < 32)
		ReturnValue[i] = A[i] && B[i]

		i += 1
	EndWhile

	return ReturnValue
EndFunction

bool[] Function ABitwiseNAND(bool[] A, bool[] B) Global
	bool[] ReturnValue = new bool[32]

	int i = 0
	While(i < 32)
		ReturnValue[i] = !(A[i] && B[i])

		i += 1
	EndWhile

	return ReturnValue
EndFunction

bool[] Function ABitwiseOR(bool[] A, bool[] B) Global
	bool[] ReturnValue = new bool[32]

	int i = 0
	While(i < 32)
		ReturnValue[i] = A[i] || B[i]

		i += 1
	EndWhile

	return ReturnValue
EndFunction

bool[] Function ABitwiseNOR(bool[] A, bool[] B) Global
	bool[] ReturnValue = new bool[32]

	int i = 0
	While(i < 32)
		ReturnValue[i] = !(A[i] || B[i])

		i += 1
	EndWhile

	return ReturnValue
EndFunction

bool[] Function ABitwiseXOR(bool[] A, bool[] B) Global
	bool[] ReturnValue = new bool[32]

	bool Val1
	bool Val2

	int i = 0
	While(i < 32)
		Val1 = A[i]
		Val2 = B[i]
		ReturnValue[i] = (!Val1 && Val2) || (Val1 && !Val2)

		i += 1
	EndWhile

	return ReturnValue
EndFunction

bool[] Function ABitwiseXNOR(bool[] A, bool[] B) Global
	bool[] ReturnValue = new bool[32]

	bool Val1
	bool Val2

	int i = 0
	While(i < 32)
		Val1 = A[i]
		Val2 = B[i]
		ReturnValue[i] = !((!Val1 && Val2) || (Val1 && !Val2))

		i += 1
	EndWhile

	return ReturnValue
EndFunction

bool[] Function ABitwiseNOT(bool[] A) Global
	bool[] ReturnValue = new bool[32]

	int i = 0
	While(i < 32)
		ReturnValue[i] = !A[i]

		i += 1
	EndWhile

	return ReturnValue
EndFunction

; not used (or implemented), but if the Bitwise* functions grow any it would
; be worth using ApplyBitwise instead to reduce code duplication
int Function ApplyBitwise(string Fname, int A, int B)
EndFunction

int Function BitwiseAND(int A, int B) Global
	return ArrayToInt(ABitwiseAND(IntToArray(A), IntToArray(B)))
EndFunction

int Function BitwiseNAND(int A, int B) Global
	return ArrayToInt(ABitwiseNAND(IntToArray(A), IntToArray(B)))
EndFunction

int Function BitwiseOR(int A, int B) Global
	return ArrayToInt(ABitwiseOR(IntToArray(A), IntToArray(B)))
EndFunction

int Function BitwiseNOR(int A, int B) Global
	return ArrayToInt(ABitwiseNOR(IntToArray(A), IntToArray(B)))
EndFunction

int Function BitwiseXOR(int A, int B) Global
	return ArrayToInt(ABitwiseXOR(IntToArray(A), IntToArray(B)))
EndFunction

int Function BitwiseXNOR(int A, int B) Global
	return ArrayToInt(ABitwiseXNOR(IntToArray(A), IntToArray(B)))
EndFunction

int Function BitwiseNOT(int A) Global
	return ArrayToInt(ABitwiseNOT(IntToArray(A)))
EndFunction
