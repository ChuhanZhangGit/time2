import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Switch, Route, NavLink, Link } from 'react-router-dom';
import { Navbar, Nav } from 'react-bootstrap';
import { Provider, connect } from 'react-redux';

import PhotosList from './photos/index';
import PhotosNew from './photos/new';
import PhotosShow from './photos/show';

import store from './store';

export default function init_page(root) {
    let tree = (
        <Provider store={store}>
            <Page />
        </Provider>
    );
    ReactDOM.render(tree, root);
}

function Page(props) {
    return (
        <Router>
            <Navbar bg="dark" variant="dark">
                <Nav>
                    <Nav.Item>
                        <NavLink to="/" exact activeClassName="active" className="nav-link">
                            Home
            </NavLink>
                    </Nav.Item>
                    <Nav.Item>
                        <NavLink to="/users" exact activeClassName="active" className="nav-link">
                            Users
            </NavLink>
                    </Nav.Item>
                    <Nav.Item>
                        <NavLink to="/photos/new" exact activeClassName="active" className="nav-link">
                            New Photo
            </NavLink>
                    </Nav.Item>
                </Nav>
            </Navbar>

            <Switch>
                <Route exact path="/">
                    <PhotosList />
                </Route>

                <Route exact path="/users">
                    <h1>Users</h1>
                </Route>

                <Route exact path="/photos/new">
                    <PhotosNew />
                </Route>

                <Route exact path="/photos/:id" render={(props) =>
                    <PhotosShow id={props.match.params.id} />
                } />
            </Switch>
        </Router>
    );
}
