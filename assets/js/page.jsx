import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Switch, Route, NavLink, Link } from 'react-router-dom';
import { Navbar, Nav, Col } from 'react-bootstrap';
import { Provider, connect } from 'react-redux';
import NewTimesheet from './timesheet/new'
import ShowTimesheet from './timesheet/show'
import Login from './login';

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
                <Col md="8">
                    <Nav>
                        <Nav.Item>
                            <NavLink to="/" exact activeClassName="active" className="nav-link">
                                Home
              </NavLink>
                        </Nav.Item>
                        <Nav.Item>
                            <NavLink to="/listsheet" exact activeClassName="active" className="nav-link">
                                Timesheet List
                            </NavLink>
                        </Nav.Item>
                        <Nav.Item>
                            <NavLink to="/newsheet" exact activeClassName="active" className="nav-link">
                                New Timesheet
                            </NavLink>
                        </Nav.Item>
                    </Nav>
                </Col>
                <Col md="4">
                    <Session />
                </Col>
            </Navbar>

            <Switch>

                <Route exact path="/listsheet">
                    <ShowTimesheet />
                </Route>
                <Route exact path="/newsheet">
                    <NewTimesheet />
                </Route>


                <Route exact path="/login">
                    <Login />
                </Route>
            </Switch>
        </Router>
    );
}

let Session = connect(({ session }) => ({ session }))(({ session, dispatch }) => {
    function logout(ev) {
        ev.preventDefault();
        localStorage.removeItem('session');
        dispatch({
            type: 'LOG_OUT',
        });
    }

    if (session) {
        console.log("username", session.user_name)
        console.log("session", session);
        return (
            <Nav>
                <Nav.Item>
                    <p className="text-light py-2">User: {
                        session.user_name}</p>
                </Nav.Item>
                <Nav.Item>
                    <a className="nav-link" href="#" onClick={logout}>Logout</a>
                </Nav.Item>
            </Nav>
        );
    }
    else {
        return (
            <Nav>
                <Nav.Item>
                    <NavLink to="/login" exact activeClassName="active" className="nav-link">
                        Login
          </NavLink>
                </Nav.Item>
            </Nav>
        );
    }
});