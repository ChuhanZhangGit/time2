import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';
import { Form, Button, Alert } from 'react-bootstrap';
import { Redirect } from 'react-router';



function state2props(state) {
    console.log("asdfasfd", state.forms.new_timesheet)
    return state.forms.new_timesheet;
}

class NewTimesheet extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            row_num: 8,
            redirect: null,
        }
    }

    redirect(path) {
        this.setState({ redirect: path });
    }

    changed(data) {
        this.props.dispatch({
            type: 'SUBMIT_NEW_SHEET',
            data: data,
        });
    }

    table_row(row_number) {
        return (<tr key={row_number}>
            <td>
                <Form.Group controlId="job_code">
                    <Form.Control as="textarea" rows="3"
                        onChange={(ev) => this.changed({ [row_number]: { job_code: ev.target.value } })} />
                </Form.Group>
            </td>
            <td>
                <Form.Group controlId="hours">
                    <Form.Control as="textarea" rows="3"
                        onChange={(ev) => this.changed({ [row_number]: { hours: ev.target.value } })} />
                </Form.Group>
            </td>
            <td>
                <Form.Group controlId="note">
                    <Form.Control as="textarea" rows="3"
                        onChange={(ev) => this.changed({ [row_number]: { note: ev.target.value } })} />
                </Form.Group>
            </td>
        </tr>);
    }

    add_row() {
        this.setState({ row_num: this.state.row_num + 1 });
    }

    render() {
        let { file, desc, errors, dispatch } = this.props;
        let error_msg = null;
        if (errors) {
            error_msg = <Alert variant="danger">{errors}</Alert>;
        }

        if (this.state.redirect) {
            return <Redirect to={this.state.redirect} />;
        }

        return (
            <div>
                <h1>New Timesheet</h1>
                {error_msg}
                <table>
                    <thead>
                        <tr>
                            <th>Job Code</th>
                            <th>Hours</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        {[...Array(this.state.row_num)].map((_, i) => this.table_row(i))}
                    </tbody>
                    <tfoot>
                        <p>
                            <Button onClick={() => this.add_row()}>Add Row</Button>
                        </p>
                    </tfoot>
                </table>

                <p>
                    <Form.Group controlId="submit">
                        <Button variant="primary"
                            onClick={() => sumbit_timesheet(this)}>
                            Submit</Button>
                    </Form.Group>
                </p>

            </div>
        );
    }
}

export default connect(state2props)(NewTimesheet);
