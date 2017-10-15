import { createStore } from 'redux'

let store = createStore(function() { return 'Hello Redux' })

var contents = document.getElementById('contents')
contents.innerHTML = store.getState().toString()
