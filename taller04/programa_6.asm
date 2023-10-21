      SET R0, 0xFD ; programa SIG 6.a.
      SIG R0
      INC R0
      SIG R0
      INC R0
      SIG R1
      SET R2, 0x05 ; programa NEG 6.b.
      NEG R2       ; NEG(00000101) = 11111010 + 1 = 11111011 = 0xFB
      SET R2, 0x00
      NEG R2       ; NEG(0x00) = 0xFF + 0x01 = 0x00
      SET R3, 0xA7 ; programa MIX 6.c.
      SET R4, 0xC5
      MIX R3, R4   ; MIX(10100111, 11000101) = 00000111 = 0x07
halt: JMP halt
