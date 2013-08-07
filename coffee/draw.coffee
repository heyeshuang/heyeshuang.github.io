c=document.getElementById("myCanvas")
cxt=c.getContext("2d")
w0=cxt.canvas.width  = window.innerWidth
h0=cxt.canvas.height = window.innerHeight
cxt.fillStyle="#333333"
cxt.fillRect(0,h0-30,w0,30)
rootX=0.2*w0
rootY=1.15*h0
length0=0.4*h0
weight0=w0/75
anRange=Math.PI/3
bRange=Math.PI/3
reduceL=0.6
reduceH=0.8
rLeaf=w0/150

numOfLoop=5
numOfBud=7
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

random=(m,n)->
  Math.random()*(n-m)+m

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
  cxt.fillStyle = "rgba(150,0,1, #{0.1})"
  cxt.fill()

#DONE:use vanilla html5 canvas
