
import store from './store';

export function post(path, body) {
    let state = store.getState();
    let token = state.session ? state.session.token : null;
    console.log(window.csrf_token)
    return fetch('/ajax' + path, {
        method: 'post',
        credentials: 'same-origin',
        headers: new Headers({
            'x-csrf-token': window.csrf_token,
            'content-type': "application/json; charset=UTF-8",
            'accept': 'application/json',
            'x-auth': token || "",
        }),
        body: JSON.stringify(body),
    }).then((resp) => resp.json());
}

export function get(path) {
    let state = store.getState();
    let token = state.session ? state.session.token : null;

    return fetch('/ajax' + path, {
        method: 'get',
        credentials: 'same-origin',
        headers: new Headers({
            'x-csrf-token': window.csrf_token,
            'content-type': "application/json; charset=UTF-8",
            'accept': 'application/json',
            'x-auth': token || "",
        }),
    }).then((resp) => resp.json());
}

// export function get_photo(id) {
//     get('/photos/' + id)
//         .then((resp) => {
//             store.dispatch({
//                 type: 'ADD_PHOTOS',
//                 data: [resp.data],
//             });
//         });
// }
export function list_jobs() {
    get('/jobs')
        .then((resp) => {
            console.log("job list", resp);
            store.dispatch({
                type: 'ADD_JOBS',
                data: resp.data,
            });
        });
}

export function sheet_list(id) {
    get('/daysheets/' + id)
        .then((resp) => {
            console.log("sheet list", resp);
            store.dispatch({
                type: 'ADD_NEW_SHEET',
                data: [resp.data],
            });
        });
}

export function sumbit_timesheet(form) {
    let state = store.getState();
    console.log("sumbit_timesheet state", state);
    let data = state.forms.new_timesheet;

    post('/daysheets', {
        daysheet:
        {
            date: state.forms.aux_sheet.date,
            tasks: data
        }
    })
        .then((resp) => {
            console.log("response", resp);
            if (resp.date) {
                store.dispatch({
                    type: 'ADD_NEW_SHEET',
                    data: [resp],
                });
                form.redirect('/listsheet/');
            }
            else {
                store.dispatch({
                    type: 'ERROR',
                    data: { errors: JSON.stringify(resp.errors) },
                });
            }
        });
}

export function submit_login(form) {
    let state = store.getState();
    let data = state.forms.login;

    post('/sessions', data)
        .then((resp) => {
            console.log("response", resp);
            if (resp.token) {
                localStorage.setItem('session', JSON.stringify(resp));
                store.dispatch({
                    type: 'LOG_IN',
                    data: resp,
                });
                form.redirect('/');
            }
            else {
                store.dispatch({
                    type: 'CHANGE_LOGIN',
                    data: { errors: JSON.stringify(resp.errors) },
                });
            }
        });
}