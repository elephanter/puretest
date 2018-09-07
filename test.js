var main = require('./output/Main');
var maybe = require('./output/Data.Maybe');

function longAnsw() {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            main.main();
        }, 10000);
    })
}
var r = main.simpleFunc("hello ")(5);
console.log("simpleFunc return " + r)

r = main.showMeSex(main.Male.value)
console.log("showMeSex return " + r)

r = main.printMaybe(new maybe.Just(main.Male.value))
console.log("printMaybe just return " + r)

r = main.printMaybe(maybe.Nothing.value)
console.log("printMaybe nothing return " + r)

r = main.retSex("vasya")
console.log("retSex return " + main.printMaybe(r) + " \n")

//test effect
r = main.testEff()
console.log("testEff return ", r + " \n")

//asyncTask
r = main.asyncTask(1000)()
console.log("asyncTask return ", r,"\n")

//calling callback
r = main.doCallback((n)=>n+"")
console.log("doCallback return " + r + "\n")

//async
r = main.doAsync((n)=>console.log("doAsync async result "+ n))()
console.log("doAsync return " + r + "\n")

//promise
r = main.doPromise().then((n)=>console.log("doPromise Got "+n))
console.log("doPromise return ", r)

//longAnsw();