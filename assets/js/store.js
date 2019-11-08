import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze-strict';

/* Structure of store data:
 * {
 *   forms: {
 *     new_sheet: {
 *      Task 1 => {jobcode: ..., .....},
 *      Task 2 => {....},
 *       ....
 *   },
 *     new_user: {...},
 *     edit_user: {...},
 *   },
 *   users: Map.new(
 *     1 => {id: 1, name: "Alice", email: "alice@example.com"},
 *     ...
 *   ),
 *   timesheets: {
 *      id =>    {approved, date, manager, worker, task_list: [task_id, ...]}   *   },
 *   tasks: {
 *      id => {jobcode, ....}
 *   }
 *   jobs: {
 *      id => {budge, desc, job_code, name, manager_id}
 *   }
 * 
 *   photos: Map.new(
 *     1 => {id: 1, data: "...", desc: "...", tags: [...]},
 *     ...
 *   ),
 * }
 */

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

function timesheets(st0 = new Map(), action) {
  switch (action.type) {
    case 'ADD_NEW_SHEET':
      let st1 = new Map(st0);
      for (let sheet of action.data) {
        st1.set(sheet.id, sheet)
      }
      return st1;
    default:
      return st0;
  }
}

function new_timesheet(st0 = new Map(), action) {
  switch (action.type) {
    case 'SUBMIT_NEW_SHEET':
      console.log("timesheet", action.data)
      let st1 = Object.assign({}, st0, action.data);
      // let st1 = new Map(st0);
      // for (let task of action.data) {
      //   st1.set(task.id, task)
      // }
      return st1;
    default:
      return st0;
  }
}


function login(st0 = { email: "", password: "", errors: null }, action) {
  switch (action.type) {
    case 'CHANGE_LOGIN':
      return Object.assign({}, st0, action.data);
    default:
      return st0;
  }
}

function forms(st0, action) {
  let reducer = combineReducers({
    new_timesheet,
    login,
  });
  return reducer(st0, action);
}

function users(st0 = new Map(), action) {
  return st0;
}



let session0 = localStorage.getItem('session');
if (session0) {
  session0 = JSON.parse(session0);
}
function session(st0 = session0, action) {
  switch (action.type) {
    case 'LOG_IN':
      return action.data;
    case 'LOG_OUT':
      return null;
    default:
      return st0;
  }
}

function root_reducer(st0, action) {
  console.log("root reducer", st0, action);
  let reducer = combineReducers({
    forms,
    users,
    session,
  });
  return deepFreeze(reducer(st0, action));
}

let store = createStore(root_reducer);
export default store;