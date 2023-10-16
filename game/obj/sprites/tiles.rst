                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module tiles
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _tiles_7
                             12 	.globl _tiles_6
                             13 	.globl _tiles_5
                             14 	.globl _tiles_4
                             15 	.globl _tiles_3
                             16 	.globl _tiles_2
                             17 	.globl _tiles_1
                             18 	.globl _tiles_0
                             19 ;--------------------------------------------------------
                             20 ; special function registers
                             21 ;--------------------------------------------------------
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _INITIALIZED
                             30 ;--------------------------------------------------------
                             31 ; absolute external ram data
                             32 ;--------------------------------------------------------
                             33 	.area _DABS (ABS)
                             34 ;--------------------------------------------------------
                             35 ; global & static initialisations
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _GSINIT
                             39 	.area _GSFINAL
                             40 	.area _GSINIT
                             41 ;--------------------------------------------------------
                             42 ; Home
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _HOME
                             46 ;--------------------------------------------------------
                             47 ; code
                             48 ;--------------------------------------------------------
                             49 	.area _CODE
                             50 	.area _CODE
   4000                      51 _tiles_0:
   4000 F3                   52 	.db #0xf3	; 243
   4001 D9                   53 	.db #0xd9	; 217
   4002 F3                   54 	.db #0xf3	; 243
   4003 D9                   55 	.db #0xd9	; 217
   4004 CC                   56 	.db #0xcc	; 204
   4005 CC                   57 	.db #0xcc	; 204
   4006 CC                   58 	.db #0xcc	; 204
   4007 CC                   59 	.db #0xcc	; 204
   4008 CC                   60 	.db #0xcc	; 204
   4009 CC                   61 	.db #0xcc	; 204
   400A CC                   62 	.db #0xcc	; 204
   400B CC                   63 	.db #0xcc	; 204
   400C F3                   64 	.db #0xf3	; 243
   400D D9                   65 	.db #0xd9	; 217
   400E F3                   66 	.db #0xf3	; 243
   400F D9                   67 	.db #0xd9	; 217
   4010 D9                   68 	.db #0xd9	; 217
   4011 F3                   69 	.db #0xf3	; 243
   4012 D9                   70 	.db #0xd9	; 217
   4013 F3                   71 	.db #0xf3	; 243
   4014 CC                   72 	.db #0xcc	; 204
   4015 CC                   73 	.db #0xcc	; 204
   4016 CC                   74 	.db #0xcc	; 204
   4017 CC                   75 	.db #0xcc	; 204
   4018 CC                   76 	.db #0xcc	; 204
   4019 CC                   77 	.db #0xcc	; 204
   401A CC                   78 	.db #0xcc	; 204
   401B CC                   79 	.db #0xcc	; 204
   401C D9                   80 	.db #0xd9	; 217
   401D F3                   81 	.db #0xf3	; 243
   401E D9                   82 	.db #0xd9	; 217
   401F F3                   83 	.db #0xf3	; 243
   4020                      84 _tiles_1:
   4020 03                   85 	.db #0x03	; 3
   4021 03                   86 	.db #0x03	; 3
   4022 03                   87 	.db #0x03	; 3
   4023 03                   88 	.db #0x03	; 3
   4024 03                   89 	.db #0x03	; 3
   4025 F0                   90 	.db #0xf0	; 240
   4026 F0                   91 	.db #0xf0	; 240
   4027 03                   92 	.db #0x03	; 3
   4028 52                   93 	.db #0x52	; 82	'R'
   4029 70                   94 	.db #0x70	; 112	'p'
   402A F0                   95 	.db #0xf0	; 240
   402B A1                   96 	.db #0xa1	; 161
   402C A1                   97 	.db #0xa1	; 161
   402D 70                   98 	.db #0x70	; 112	'p'
   402E F0                   99 	.db #0xf0	; 240
   402F 52                  100 	.db #0x52	; 82	'R'
   4030 03                  101 	.db #0x03	; 3
   4031 43                  102 	.db #0x43	; 67	'C'
   4032 83                  103 	.db #0x83	; 131
   4033 03                  104 	.db #0x03	; 3
   4034 03                  105 	.db #0x03	; 3
   4035 C3                  106 	.db #0xc3	; 195
   4036 C3                  107 	.db #0xc3	; 195
   4037 03                  108 	.db #0x03	; 3
   4038 03                  109 	.db #0x03	; 3
   4039 F0                  110 	.db #0xf0	; 240
   403A F0                  111 	.db #0xf0	; 240
   403B 03                  112 	.db #0x03	; 3
   403C A1                  113 	.db #0xa1	; 161
   403D 70                  114 	.db #0x70	; 112	'p'
   403E F0                  115 	.db #0xf0	; 240
   403F 52                  116 	.db #0x52	; 82	'R'
   4040                     117 _tiles_2:
   4040 03                  118 	.db #0x03	; 3
   4041 03                  119 	.db #0x03	; 3
   4042 03                  120 	.db #0x03	; 3
   4043 03                  121 	.db #0x03	; 3
   4044 A1                  122 	.db #0xa1	; 161
   4045 03                  123 	.db #0x03	; 3
   4046 E5                  124 	.db #0xe5	; 229
   4047 03                  125 	.db #0x03	; 3
   4048 03                  126 	.db #0x03	; 3
   4049 03                  127 	.db #0x03	; 3
   404A A1                  128 	.db #0xa1	; 161
   404B 03                  129 	.db #0x03	; 3
   404C 03                  130 	.db #0x03	; 3
   404D 03                  131 	.db #0x03	; 3
   404E 03                  132 	.db #0x03	; 3
   404F 03                  133 	.db #0x03	; 3
   4050 47                  134 	.db #0x47	; 71	'G'
   4051 03                  135 	.db #0x03	; 3
   4052 52                  136 	.db #0x52	; 82	'R'
   4053 03                  137 	.db #0x03	; 3
   4054 03                  138 	.db #0x03	; 3
   4055 03                  139 	.db #0x03	; 3
   4056 03                  140 	.db #0x03	; 3
   4057 03                  141 	.db #0x03	; 3
   4058 03                  142 	.db #0x03	; 3
   4059 03                  143 	.db #0x03	; 3
   405A 03                  144 	.db #0x03	; 3
   405B 03                  145 	.db #0x03	; 3
   405C 8B                  146 	.db #0x8b	; 139
   405D 03                  147 	.db #0x03	; 3
   405E A1                  148 	.db #0xa1	; 161
   405F 03                  149 	.db #0x03	; 3
   4060                     150 _tiles_3:
   4060 FF                  151 	.db #0xff	; 255
   4061 FF                  152 	.db #0xff	; 255
   4062 FF                  153 	.db #0xff	; 255
   4063 FF                  154 	.db #0xff	; 255
   4064 FF                  155 	.db #0xff	; 255
   4065 FF                  156 	.db #0xff	; 255
   4066 FF                  157 	.db #0xff	; 255
   4067 FF                  158 	.db #0xff	; 255
   4068 FF                  159 	.db #0xff	; 255
   4069 FF                  160 	.db #0xff	; 255
   406A FF                  161 	.db #0xff	; 255
   406B FF                  162 	.db #0xff	; 255
   406C FF                  163 	.db #0xff	; 255
   406D FF                  164 	.db #0xff	; 255
   406E FF                  165 	.db #0xff	; 255
   406F FF                  166 	.db #0xff	; 255
   4070 FF                  167 	.db #0xff	; 255
   4071 FF                  168 	.db #0xff	; 255
   4072 FF                  169 	.db #0xff	; 255
   4073 FF                  170 	.db #0xff	; 255
   4074 FF                  171 	.db #0xff	; 255
   4075 FF                  172 	.db #0xff	; 255
   4076 FF                  173 	.db #0xff	; 255
   4077 FF                  174 	.db #0xff	; 255
   4078 FF                  175 	.db #0xff	; 255
   4079 FF                  176 	.db #0xff	; 255
   407A FF                  177 	.db #0xff	; 255
   407B FF                  178 	.db #0xff	; 255
   407C FF                  179 	.db #0xff	; 255
   407D FF                  180 	.db #0xff	; 255
   407E FF                  181 	.db #0xff	; 255
   407F FF                  182 	.db #0xff	; 255
   4080                     183 _tiles_4:
   4080 FF                  184 	.db #0xff	; 255
   4081 FF                  185 	.db #0xff	; 255
   4082 FF                  186 	.db #0xff	; 255
   4083 FF                  187 	.db #0xff	; 255
   4084 FF                  188 	.db #0xff	; 255
   4085 FF                  189 	.db #0xff	; 255
   4086 FF                  190 	.db #0xff	; 255
   4087 FF                  191 	.db #0xff	; 255
   4088 FF                  192 	.db #0xff	; 255
   4089 FF                  193 	.db #0xff	; 255
   408A FF                  194 	.db #0xff	; 255
   408B FF                  195 	.db #0xff	; 255
   408C FF                  196 	.db #0xff	; 255
   408D FF                  197 	.db #0xff	; 255
   408E FF                  198 	.db #0xff	; 255
   408F FF                  199 	.db #0xff	; 255
   4090 FF                  200 	.db #0xff	; 255
   4091 FF                  201 	.db #0xff	; 255
   4092 FF                  202 	.db #0xff	; 255
   4093 FF                  203 	.db #0xff	; 255
   4094 FF                  204 	.db #0xff	; 255
   4095 FF                  205 	.db #0xff	; 255
   4096 FF                  206 	.db #0xff	; 255
   4097 FF                  207 	.db #0xff	; 255
   4098 FF                  208 	.db #0xff	; 255
   4099 FF                  209 	.db #0xff	; 255
   409A FF                  210 	.db #0xff	; 255
   409B FF                  211 	.db #0xff	; 255
   409C FF                  212 	.db #0xff	; 255
   409D FF                  213 	.db #0xff	; 255
   409E FF                  214 	.db #0xff	; 255
   409F FF                  215 	.db #0xff	; 255
   40A0                     216 _tiles_5:
   40A0 FF                  217 	.db #0xff	; 255
   40A1 FF                  218 	.db #0xff	; 255
   40A2 FF                  219 	.db #0xff	; 255
   40A3 FF                  220 	.db #0xff	; 255
   40A4 FF                  221 	.db #0xff	; 255
   40A5 FF                  222 	.db #0xff	; 255
   40A6 FF                  223 	.db #0xff	; 255
   40A7 FF                  224 	.db #0xff	; 255
   40A8 FF                  225 	.db #0xff	; 255
   40A9 FF                  226 	.db #0xff	; 255
   40AA FF                  227 	.db #0xff	; 255
   40AB FF                  228 	.db #0xff	; 255
   40AC FF                  229 	.db #0xff	; 255
   40AD FF                  230 	.db #0xff	; 255
   40AE FF                  231 	.db #0xff	; 255
   40AF FF                  232 	.db #0xff	; 255
   40B0 FF                  233 	.db #0xff	; 255
   40B1 FF                  234 	.db #0xff	; 255
   40B2 FF                  235 	.db #0xff	; 255
   40B3 FF                  236 	.db #0xff	; 255
   40B4 FF                  237 	.db #0xff	; 255
   40B5 FF                  238 	.db #0xff	; 255
   40B6 FF                  239 	.db #0xff	; 255
   40B7 FF                  240 	.db #0xff	; 255
   40B8 FF                  241 	.db #0xff	; 255
   40B9 FF                  242 	.db #0xff	; 255
   40BA FF                  243 	.db #0xff	; 255
   40BB FF                  244 	.db #0xff	; 255
   40BC FF                  245 	.db #0xff	; 255
   40BD FF                  246 	.db #0xff	; 255
   40BE FF                  247 	.db #0xff	; 255
   40BF FF                  248 	.db #0xff	; 255
   40C0                     249 _tiles_6:
   40C0 FF                  250 	.db #0xff	; 255
   40C1 FF                  251 	.db #0xff	; 255
   40C2 FF                  252 	.db #0xff	; 255
   40C3 FF                  253 	.db #0xff	; 255
   40C4 FF                  254 	.db #0xff	; 255
   40C5 FF                  255 	.db #0xff	; 255
   40C6 FF                  256 	.db #0xff	; 255
   40C7 FF                  257 	.db #0xff	; 255
   40C8 FF                  258 	.db #0xff	; 255
   40C9 FF                  259 	.db #0xff	; 255
   40CA FF                  260 	.db #0xff	; 255
   40CB FF                  261 	.db #0xff	; 255
   40CC FF                  262 	.db #0xff	; 255
   40CD FF                  263 	.db #0xff	; 255
   40CE FF                  264 	.db #0xff	; 255
   40CF FF                  265 	.db #0xff	; 255
   40D0 FF                  266 	.db #0xff	; 255
   40D1 FF                  267 	.db #0xff	; 255
   40D2 FF                  268 	.db #0xff	; 255
   40D3 FF                  269 	.db #0xff	; 255
   40D4 FF                  270 	.db #0xff	; 255
   40D5 FF                  271 	.db #0xff	; 255
   40D6 FF                  272 	.db #0xff	; 255
   40D7 FF                  273 	.db #0xff	; 255
   40D8 FF                  274 	.db #0xff	; 255
   40D9 FF                  275 	.db #0xff	; 255
   40DA FF                  276 	.db #0xff	; 255
   40DB FF                  277 	.db #0xff	; 255
   40DC FF                  278 	.db #0xff	; 255
   40DD FF                  279 	.db #0xff	; 255
   40DE FF                  280 	.db #0xff	; 255
   40DF FF                  281 	.db #0xff	; 255
   40E0                     282 _tiles_7:
   40E0 FF                  283 	.db #0xff	; 255
   40E1 FF                  284 	.db #0xff	; 255
   40E2 FF                  285 	.db #0xff	; 255
   40E3 FF                  286 	.db #0xff	; 255
   40E4 FF                  287 	.db #0xff	; 255
   40E5 FF                  288 	.db #0xff	; 255
   40E6 FF                  289 	.db #0xff	; 255
   40E7 FF                  290 	.db #0xff	; 255
   40E8 FF                  291 	.db #0xff	; 255
   40E9 FF                  292 	.db #0xff	; 255
   40EA FF                  293 	.db #0xff	; 255
   40EB FF                  294 	.db #0xff	; 255
   40EC FF                  295 	.db #0xff	; 255
   40ED FF                  296 	.db #0xff	; 255
   40EE FF                  297 	.db #0xff	; 255
   40EF FF                  298 	.db #0xff	; 255
   40F0 FF                  299 	.db #0xff	; 255
   40F1 FF                  300 	.db #0xff	; 255
   40F2 FF                  301 	.db #0xff	; 255
   40F3 FF                  302 	.db #0xff	; 255
   40F4 FF                  303 	.db #0xff	; 255
   40F5 FF                  304 	.db #0xff	; 255
   40F6 FF                  305 	.db #0xff	; 255
   40F7 FF                  306 	.db #0xff	; 255
   40F8 FF                  307 	.db #0xff	; 255
   40F9 FF                  308 	.db #0xff	; 255
   40FA FF                  309 	.db #0xff	; 255
   40FB FF                  310 	.db #0xff	; 255
   40FC FF                  311 	.db #0xff	; 255
   40FD FF                  312 	.db #0xff	; 255
   40FE FF                  313 	.db #0xff	; 255
   40FF FF                  314 	.db #0xff	; 255
                            315 	.area _INITIALIZER
                            316 	.area _CABS (ABS)
