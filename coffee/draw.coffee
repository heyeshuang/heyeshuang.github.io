elem=document.getElementById('content').children[0]
params = { width: 1000, height: 1000 }
two = new Two(params).appendTo(elem)
numOfLoop=4
numOfBud=1
line=0
drawBranch=(x1,y1,x2,y2,i)->
  line=two.makeLine(x1,y1,x2,y2)
  console.log("...")
  line.linewidth=19-5*i
  if i>numOfLoop
    return
  else
    for j in [1..numOfBud]
      arguments.callee(x2,y2,x2+200*Math.random(),y2+200*Math.random(),i+1)

drawBranch(10,10,200,200,0)


two.update()
