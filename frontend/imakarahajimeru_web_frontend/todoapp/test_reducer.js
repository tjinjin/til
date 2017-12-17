import todoApp from './reducers/index.js'

var initialState = todoApp({},{});
console.log(initialState);

var nextState = todoApp(initialState, {type:'ADD_TODO', id:1, text:'First todo'});
console.log(nextState)
