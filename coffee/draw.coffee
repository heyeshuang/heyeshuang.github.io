c=document.getElementById("myCanvas")
cxt=c.getContext("2d")
w0=cxt.canvas.width  = window.innerWidth
h0=cxt.canvas.height = window.innerHeight
cxt.fillStyle="#444444"
cxt.fillRect(0,h0-18,w0,30)

random=(m,n)->
  Math.random()*(n-m)+m

rootX=0.3*w0
rootY=1.25*h0
length0=0.5*h0
weight0=w0/75
anRange=Math.PI/3
bRange=Math.PI/3
reduceL=0.6
reduceH=0.8
rLeaf=w0/150
numOfLoop=5
numOfBud=7

lColorH=155
lColorS=60 #presents emotion
lColorLA=random(20,90)
lColorLR=10

getToday = ->
  now = new Date()
  firstDay = new Date(now.getFullYear(), 0, 1)
  dateDiff = now - firstDay
  msPerDay = 1000 * 60 * 60 * 24
  diffDays = Math.ceil(dateDiff / msPerDay)
  return diffDays

lColorH=getToday()*360/365

Bud=(X,Y,X0,Y0,w,i)->
  @X=X
  @Y=Y
  @X0=X0
  @Y0=Y0
  @w=w
  @i=i

Leaf=(X,Y,r,i)->
  @X=X
  @Y=Y
  @r=r
  @i=i

budList=[]
leafList=[]

makeBranch=(x1,y1,i,l,w,a0,b0)->
  x2=x1-l*Math.sin(a0)*Math.sin(b0)
  y2=y1-l*Math.cos(a0)*Math.sin(b0)
  budList.push(new Bud(x2,y2,x1,y1,w,i))

  if i>0
    for tmp in [0..Math.ceil((numOfLoop-i+1)^2)]
      m=random(-5,5+l*Math.sin(b0))
      n=random(0,w0/30-3*i)
      y3=y1-(m*Math.cos(a0)+n*Math.sin(a0))
      x3=x1-(m*Math.sin(a0)+n*Math.cos(a0))
      r=rLeaf
      leafList.push(new Leaf(x3,y3,r,i))

  if i<numOfLoop
    for j in [1..numOfBud]
      arguments.callee(x2,y2,i+1,l*random(reduceL,reduceH),
                      w*random(reduceL-0.2,reduceH-0.2),
                      random(-anRange,anRange)+a0,
                      random(-anRange,anRange)+b0)

makeBranch(rootX,rootY,0,length0,weight0,0,Math.PI/2)

lastW=budList[0].w
cxt.lineWidth=lastW
cxt.beginPath()
for bud in budList
  if bud.w!=lastW
    cxt.closePath()
    cxt.stroke()
    lastW=bud.w
    cxt.lineWidth=bud.w
    cxt.strokeStyle="rgba(0,0,0,#{1-bud.i/numOfLoop/1.1})"
    cxt.beginPath()
  cxt.moveTo(bud.X,bud.Y)
  cxt.lineTo(bud.X0,bud.Y0)
cxt.closePath()
cxt.stroke()
for leaf in leafList
  cxt.beginPath()
  cxt.arc(leaf.X,leaf.Y,leaf.r,0,2*Math.PI)
  cxt.closePath()
  cxt.fillStyle=
    "hsla(#{lColorH},#{lColorS}%,#{random(lColorLA-lColorLR,lColorLA+lColorLR)}%,0.1)"
  # cxt.fillStyle="rgba(#{Math.round(Math.random()*255)},#{Math.round(Math.random()*255)},#{Math.round(Math.random()*255)},0.1)"
  # it's a kind of ... crazy
  # cxt.fillStyle = "rgba(#{leafColor[0]},
    # #{leafColor[1]}, #{leafColor[2]}, #{0.1})"
  cxt.fill()

cxt.textBaseline="bottom"
cxt.font="10px italic Serif"
cxt.fillStyle="#000000"
cxt.fillText("#{lColorH},#{lColorS},#{lColorLA}",10,h0)
cxt.textAlign="right"
cxt.fillText("mailto:yeshuanghe#gmail",w0-10,h0)
