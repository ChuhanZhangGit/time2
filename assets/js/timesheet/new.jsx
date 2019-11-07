import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';
import { Form, Button, Alert } from 'react-bootstrap';
import { Redirect } from 'react-router';

import { submit_new_photo } from '../ajax';

export default connect(state2props)(PhotosNew);

function state2props(state) {
    return state.forms.new_photo;
}

class PhotosNew extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            redirect: null,
        }
    }

    redirect(path) {
        this.setState({ redirect: path });
    }

    changed(data) {
        this.props.dispatch({
            type: 'CHANGE_NEW_PHOTO',
            data: data,
        });
    }

    file_changed(ev) {
        let input = ev.target;
        let file = null;
        if (input.files.length > 0) {
            file = input.files[0];
        }
        this.changed({ file: file });
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
                <h1>New Photo</h1>
                {error_msg}
                <Form.Group controlId="upload">
                    <Form.Label>Upload Photo</Form.Label>
                    <Form.Control type="file" onChange={(ev) => this.file_changed(ev)} />
                </Form.Group>
                <Form.Group controlId="desc">
                    <Form.Label>Description</Form.Label>
                    <Form.Control as="textarea" rows="3"
                        onChange={(ev) => this.changed({ desc: ev.target.value })} />
                </Form.Group>
                <Form.Group controlId="submit">
                    <Button variant="primary"
                        onClick={() => submit_new_photo(this)}>
                        Upload Photo</Button>
                </Form.Group>
            </div>
        );
    }
}

