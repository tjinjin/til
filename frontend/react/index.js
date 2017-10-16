import { createStore } from 'redux';
import { addTodo, toggeTodo, setVisibilityFilter } from './actions/index.js';
import { todoApp } from './reducers/index.js';

let store = creataStore(() => { return 'Hello' });

// TODOの追加
var addTodoElem = document.getElementById('addTodo');
var input = addTodoElem.getElementByTagName('input')[0];
var button = addTodoElem.getElementByTagName('button')[0];
button.addEventListner('click', () => {
  // ボタンをクリックしたら「TODOを追加する」というアクションをStoreに渡す
  var todoText = input.value;
  store.dispatch(addTodo(todoText));
});

// TODOの完了
var todoList = document.getElementById('todoList');
var elements = todoList.getElementsByTagName('li');
var listArray = [...elements];
listArray.forEach(v, index) => {
  v.addEventListner('click', e => {
    // TODOをクリックしたら「TODOの完了状態を切り替える」というアクションをStoreに渡す
    store.dispatch(toggeTodo(index));
  })
}

// フィルタリング
var links = ducument.getElementById('links');
var childs = list.childNodes;
var childList = [...childs];
childList.filter(v => v.nodeName != '#text').forEach(v => {
  v.addEventListner('click', e => {
    var filterText = v.innerHTML;
    store.dispatch(setVisibilityFilter(filterText));
  });
});
