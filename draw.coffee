c=document.getElementById("myCanvas")
cxt=c.getContext("2d")
w0=cxt.canvas.width  = window.innerWidth
h0=cxt.canvas.height = window.innerHeight

random=(m,n)->
  Math.random()*(n-m)+m

getToday = ->
  now = new Date()
  firstDay = new Date(now.getFullYear(), 0, 1)
  dateDiff = now - firstDay
  msPerDay = 1000 * 60 * 60 * 24
  diffDays = Math.ceil(dateDiff / msPerDay)
  return diffDays

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
maxLength=200 # branches to draw one time
maxLeaf=50
lColor=
  H:155
  S:75 #presents emotion
  LA:random(20,70)
  LR:10

lColor.H=getToday()*360/365

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
budListDone=[]
budListForDraw=[]
leafList=[]
leafListDone=[]
leafListForDraw=[]

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
      makeBranch(x2,y2,i+1,l*random(reduceL,reduceH),
                      w*random(reduceL-0.2,reduceH-0.2),
                      random(-anRange,anRange)+a0,
                      random(-anRange,anRange)+b0)

makeBranch(rootX,rootY,0,length0,weight0,0,Math.PI/2)

budList.sort((a,b)->
  a.i-b.i
  ) #to be optimized

canvasClean=()->
  cxt.clearRect(0,0,w0,h0)
  w0=cxt.canvas.width  = window.innerWidth
  h0=cxt.canvas.height = window.innerHeight
  return

drawBranch=()->
  for j in [0...budList.length]
    bud=budList.shift()
    budListDone.push(bud)
    if budListForDraw.length==0 or
    ( budListForDraw[budListForDraw.length-1].i==bud.i and
    budListForDraw.length<maxLength )
      budListForDraw.push(bud)
    else
      animatedBranch(budListForDraw,0)
      budListForDraw=[]
      budListForDraw.push(bud)
      break

  # cxt.beginPath()
  # for bud in budList
  #   if bud.w!=lastW
  #     cxt.closePath()
  #     cxt.stroke()
  #     lastW=bud.w
  #     cxt.lineWidth=bud.w
  #     cxt.strokeStyle="rgba(0,0,0,#{1-bud.i/numOfLoop/1.1})"
  #     cxt.beginPath()
  #   cxt.moveTo(bud.X,bud.Y)
  #   cxt.lineTo(bud.X0,bud.Y0)
  # cxt.closePath()
  # cxt.stroke()

animatedBranch=(budList,t)->
  # console.log(budList)
  for bud in budList
    cxt.lineWidth=bud.w
    cxt.strokeStyle="rgba(0,0,0,#{1-bud.i/numOfLoop/1.1})"
    cxt.beginPath()
    cxt.moveTo(bud.X0+(bud.X-bud.X0)*t,bud.Y0+(bud.Y-bud.Y0)*t)
    cxt.lineTo(bud.X0+(bud.X-bud.X0)*(t+0.1),bud.Y0+(bud.Y-bud.Y0)*(t+0.1))
    cxt.closePath()
    cxt.stroke()
  if t<1-0.2
    requestAnimationFrame(->
      animatedBranch(budList,t+0.1)
      )
  else drawBranch()


drawLeaf=()->
  for j in [1..maxLeaf]
    leaf=leafList.shift()
    leafListDone.push(leaf)
    cxt.beginPath()
    cxt.arc(leaf.X,leaf.Y,leaf.r,0,2*Math.PI)
    cxt.closePath()
    cxt.fillStyle=
      "hsla(#{lColor.H},"+
      "#{lColor.S}%,"+
      "#{random(lColor.LA-lColor.LR,lColor.LA+lColor.LR)}%,0.05) "
    cxt.fill()
  requestAnimationFrame(drawLeaf)
  # for leaf in leafList
  #   cxt.beginPath()
  #   cxt.arc(leaf.X,leaf.Y,leaf.r,0,2*Math.PI)
  #   cxt.closePath()
  #   if not fuzzy
  #     cxt.fillStyle=
  #       "hsla(#{lColor.H},"+
  #       "#{lColor.S}%,"+
  #       "#{random(lColor.LA-lColor.LR,lColor.LA+lColor.LR)}%,0.1)"
  #   else
  #     cxt.fillStyle=
  #       "rgba(#{Math.round(Math.random()*255)},"+
  #       "#{Math.round(Math.random()*255)},"+
  #       "#{Math.round(Math.random()*255)},0.2)"
  #   cxt.fill()

drawMisc=()->
  cxt.globalCompositeOperation="destination-over"
  cxt.fillStyle="#444444"
  cxt.fillRect(0,h0-18,w0,30)

  cxt.globalCompositeOperation="source-over"
  cxt.textBaseline="bottom"
  cxt.font="10px italic Serif"
  cxt.fillStyle="#000000"
  # cxt.fillText("#{lColor.H},#{lColor.S},#{lColor.LA}",10,h0)
  cxt.textAlign="right"
  cxt.fillText("mailto:yeshuanghe#gmail",w0-10,h0)

setTimeout(->
  canvasClean()
  drawBranch()
  # drawLeaf(leafList,lColor)
  drawLeaf()
  drawMisc()
  return
,100)
document.getElementById("fuzzy").addEventListener("click", ->
  canvasClean()
  drawBranch()
  drawLeaf(leafList,lColor,fuzzy=true)
  drawMisc()
  )
document.getElementById("orange").addEventListener("click", ->
  canvasClean()
  drawBranch()
  # drawLeaf(leafList,lColor)
  drawMisc()
  )
document.getElementById("restore").addEventListener("click", ->
  canvasClean()
  drawBranch()
  drawLeaf(leafList,lColor)
  drawMisc()
  )
