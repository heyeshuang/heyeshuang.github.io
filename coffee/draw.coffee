elem=document.getElementById('content').children[0]
params =
  width: 1000,
  height: 1000,
  type: Two.Types.webgl
two = new Two(params).appendTo(elem)
numOfLoop=5
numOfBud=5
Bud=(X,Y,X0,Y0,i)->
  this.X=X
  this.Y=Y
  this.X0=X0
  this.Y0=Y0
budList=[]
makeBranch=(x1,y1,x2,y2,i)->
  budList.push(new Bud(x2,y2,x1,y1,i))
  if i>numOfLoop
    return
  else
    for j in [1..numOfBud]
      arguments.callee(x2,y2,x2+100*Math.random(),y2+100*Math.random(),i+1)

makeBranch(10,10,100,100,1)

for bud in budList
  line=two.makeLine(bud.X,bud.Y,bud.X0,bud.Y0)
  # line.linewidth=31-3*bud.i

two.update()
#TODO:use vanilla html5 canvas
