S={0,3,1,1,0,0,5,7, -- speeds, chords
   1,1,2,1,2,1,2,0, -- chn 0  
   0,0,0,3,3,3,3,0, -- chn 1
   0,2,1,2,1,2,1,2, -- chn 2
   0,4,4,0,4,4,4,4, -- chn 3 (kick)
   1,0,1,3,4,0,1,2, -- pat 1
   1,0,1,3,4,1,1,2, -- pat 2
   1,0,2,3,3,0,4,3, -- pat 3
   1,0,1,0,1,0,1,1} -- pat 4 (kick)

t=0
function TIC()
--music:
 p=t//1024
	for k=0,3 do 	
	e=t*2/2^S[k+1]
	w=S[p+k*8+9]
	n=S[w*8+33+e//16%8] 
	sfx(0,
	    10 -- adjust pitch for song
	     +k*12 -- each instr 1 oct. apart
						+p%6//4*S[5+t//128%4] -- chord change
						+(n-1)*(9-n) -- minor chord
						-k//3*e%16*8|0,
					9*n*w, -- 0 pat & 0 note are silent
					k, -- channel k
					-e)-- decreasing envelope
	end
--visuals:

 cls()
 for y=0,136,9 do 
 for x=0,240,9 do
 circ(x,y,math.sin(math.sin(x+t/23)+math.sin(y+t/27)+x/30+y/37+t/45)*5,12)
 end
 end


	t=t+1

 q=t<8300or exit()	
end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

