S={0,3,1,1, -- pattern speeds
   0,0,5,7, -- chords (i,i,iv,v)
   1,1,2,1,2,1,2,0, -- chn 0 bass 
   0,0,0,3,3,3,3,0, -- chn 1 mid
   0,2,1,2,1,2,1,2, -- chn 2 treble
   0,4,4,0,4,4,4,4, -- chn 3 (kick)
   1,0,1,3,4,0,1,2, -- pat 1
   1,0,1,3,4,1,1,2, -- pat 2
   1,0,2,3,3,0,4,3, -- pat 3
   1,0,1,0,1,0,1,1} -- pat 4 (kick)

t=0
N={}
s=math.sin

function TIC()
--music:
 p=t//1024
 c=p%6//4*S[5+t//128%4]
	for k=0,3 do 	
	e=t*2/2^S[k+1]
	w=S[p+k*8+9]
	n=S[w*8+33+e//16%8] 
	N[k]=n*w>0 and -e%16 or 0
	sfx(0,
	    10 -- adjust pitch for song
	     +k*12 -- each instr 1 oct. apart
						+c -- chord change
						+(n-1)*(9-n) -- minor chord
						-k//3*e%16*8|0,
					9*n*w, -- 0 pat & 0 note are silent
					k, -- channel k
					-e)-- decreasing envelope
	end
--visuals:

 cls()
  for z=5,.07,-.01 do
    l=t/10+z*(p%4)^3
    circb(120+s(l/4)*19/z,68+s(l/3)*19/z,99/z,z/4-1+N[1]/4)    
    l=p<3 and l//1 or l    
				n=5/z    
    for i=0,9 do
      q=(s(i*3+l)+1.5+i/9)/z*19
      w=i*8 + s(i*4+l) + s(s(t/20)+t/30)     
      x=s(w)*q+120
      y=s(w+8)*q+68
      c=-2^-z*N[3]/2
      n=3/z
      if p%4==2 then
        rect(x-n/2,
             y-n/2,
             n,n,-c)
      else
        (p%3==1 and circb or circ)
          (x,y,n,c)      
      end
    end
  end

 q=(p-1)%7<6or print(t//512%2<1 and"brainlez Coders!"or"  cracklebass",80,66,12)

	t=t+1

 q=t<8306or exit()	
 
 if btn(2) then t=t-100 end	
 if btn(3) then t=t+100 end
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

