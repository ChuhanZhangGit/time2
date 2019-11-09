import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';

import { sheet_list } from '../ajax';

function state2props(state) {
    return { id: state.session.user_id, sheet: state.timesheets };
}

function ShowTimesheet({ id, sheet }) {

    sheet_list(id);
    console.log("asdfasd", sheet)
    if (sheet.date) {
        return (

            <div>
                <h1>Show Timesheet</h1>
                {[...Array(sheet.length)].map((_, i) =>
                    (
                        <div>
                            <p>Date: {sheet[i].date} </p>
                            <p>Status: {sheet[i].approved}</p>
                        </div>))}


            </div>

        );
    }
    else {
        return null;
    }


}

export default connect(state2props)(ShowTimesheet);
