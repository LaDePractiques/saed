//db connection
const HOST = '10.0.2.2';
const PORT = 3306;
const USER = 'rootdb';
const DB = 'revisiones_spmaritim';
const PSW = 'admin';

//script php
const ROOT_USER_ACTION =
    'http://10.0.2.2/revisiones_spmaritim/user_actions.php';
const GET_ALL_USERS_ACTION = 'GET_ALL_USERS';
const ADD_USER_ACTION = 'ADD_USER';
const UPDATE_USER_ACTION = 'UPDATE_USER';
const DELETE_USER_ACTION = 'DELETE_USER';

const ROOT_SHIP_ACTION =
    'http://10.0.2.2/revisiones_spmaritim/ship_actions.php';
const GET_ALL_SHIPS_ACTION = 'GET_ALL_SHIPS';
const GET_ALL_SHIPS_OF_USER_ACTION = 'GET_ALL_SHIPS_OF_USER';
const ADD_SHIP_ACTION = 'ADD_SHIP';
const UPDATE_SHIP_ACTION = 'UPDATE_SHIP';
const DELETE_SHIP_ACTION = 'DELETE_SHIP';

const ROOT_AUDITS_ACTION =
    'http://10.0.2.2/revisiones_spmaritim/audit_actions.php';
const GET_ALL_AUDITS_ACTION = 'GET_ALL_AUDITS';
const ADD_AUDIT_ACTION = 'ADD_AUDIT';
const UPDATE_AUDIT_ACTION = 'UPDATE_AUDIT';
const DELETE_AUDIT_ACTION = 'DELETE_AUDIT';
