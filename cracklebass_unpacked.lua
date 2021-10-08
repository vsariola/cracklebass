S={-1,2,0,0, -- pattern speeds
    0,0,5,7, -- chords (i,i,iv,v)
    1,1,2,1,2,1,2,0, -- chn 0 bass
    0,0,0,3,3,3,5,0, -- chn 1 mid
    0,2,1,2,1,2,1,2, -- chn 2 treble
    0,4,4,0,4,4,4,4, -- chn 3 kick
    1,0,1,3,4,0,1,2, -- pat 1
    1,0,1,3,4,1,1,2, -- pat 2
    1,0,2,3,3,0,4,3, -- pat 3
    1,0,1,0,1,0,1,1, -- pat 4
    1,0,0,0,1,0,3,1, -- pat 5
    9,1,9,0,1,9,1,1,1} -- tunnel widths

t=0
N={}

-- we use 3 different primitives. rectb
-- centered so behaves like elli/ellib
prim={
 elli,
 ellib,
 load'g,h,i,j,k=...rectb(g-i,h-j,i+i,j+j,k)'
}

function TIC()
 -- music:
 p=t//1024 -- part
 for k=0,3 do -- loop over channels
  e=t/2^S[k+1]
  -- get note from current pattern
  n=S[8*S[8*k+p+9]+33+e//16%8]
  -- calculate volume for channel k
  -- and store it in array for syncs
  -- the %(16*n*S...) ensures that
  -- volume is 0 when pattern or note
  -- is 0
  N[k]=-e%16%(16*n*S[8*k+p+9]+1)
  sfx(
   0,
   1-- adjust pitch for song
    +k*12 -- each instr 1 oct. apart
    +p%6//4*S[5+t//128%4] -- chord change
    -n*n+10*n -- minor chord
    -k//3*e%16*8 -- kick pitch decay
    |0, -- force integer, tic stupid
   9,
   k, -- channel k
   N[k] -- envelope/volume
  )
 end

 -- visuals:
 cls()
 -- pride first: hide cursor
 poke(16379,1)
 for z=5,.07,-.02 do
  l=t/(5+p)+z*(p%4)^3
  -- draw tunnel
  prim[2+p%6//3](
   120+19/z*s(l/4),
   70+19/z*s(l/3),
   99/z*S[p+81],
   99/z,
   (s(z+t/10)^8*N[0]*2-N[1]/z)
    *(.5-p%2)*(15-N[3])/40
  )
  -- draw 10 things in the tunnel
  for i=0,9 do
   prim[p%5%3+1](
    120+19/z*(s(i*p+p//4*l+(l-p//4*l)//1)+1.5+i/9)*s(i*8+s(i*4+p//4*l+(l-p//4*l)//1)+s(s(t/20)+t/30)),
    70+19/z*(s(i*p+p//4*l+(l-p//4*l)//1)+1.5+i/9)*s(i*8+s(i*4+p//4*l+(l-p//4*l)//1)+s(s(t/20)+t/30)+8),
    3/z,
    3/z,
    2^-z*(.5-p%2)*N[3]
   )
  end
 end


 -- increase time, exit when done
 t=t+1,t<8306 or exit()

 -- print credits
 print(
  "code:pestis     brainlez Coders!     cracklebass",
  52-(t//512+1)%15*220,
  64,
  12,
  1,
  2
 )

--uncomment these for skipping time
 --if btn(2) and t>100 then t=t-100 end
 --if btn(3) then t=t+100 end
end

s=math.sin
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

