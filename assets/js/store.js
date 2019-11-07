import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze-strict';

/* Structure of store data:
 * {
 *   forms: {
 *     new_photo: {...},
 *     edit_photo: {...},
 *     new_user: {...},
 *     edit_user: {...},
 *   },
 *   users: Map.new(
 *     1 => {id: 1, name: "Alice", email: "alice@example.com"},
 *     ...
 *   ),
 *   photos: Map.new(
 *     1 => {id: 1, data: "...", desc: "...", tags: [...]},
 *     ...
 *   ),
 * }
 */

function new_photo(st0 = {file: null, desc: "", errors: null}, action) {
  switch (action.type) {
    case 'CHANGE_NEW_PHOTO':
      return Object.assign({}, st0, action.data);
    default:
      return st0;
  }
}

function forms(st0, action) {
  let reducer = combineReducers({
    new_photo,
  });
  return reducer(st0, action);
}

function users(st0 = new Map(), action) {
  return st0;
}

function photos(st0 = new Map(), action) {
  switch (action.type) {
    case 'ADD_PHOTOS':
      let st1 = new Map(st0);
      for (let photo of action.data) {
        st1.set(photo.id, photo);
      }
      return st1;
    default:
      return st0;
  }
}

function root_reducer(st0, action) {
  console.log("root reducer", st0, action);
  let reducer = combineReducers({
    forms,
    users,
    photos,
  });
  return deepFreeze(reducer(st0, action));
}

let store = createStore(root_reducer);
export default store;
