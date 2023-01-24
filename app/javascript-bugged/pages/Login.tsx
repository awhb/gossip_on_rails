import React, { useState } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { TextField, Button } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import { Box, Paper, Typography } from '@material-ui/core';
import { useDispatch, useSelector } from 'react-redux';
import { login } from '../store/authSlice';
import LoadingSpinner from '../components/LoadingSpinner';

const useStyles = makeStyles((theme) => ({
  form: {
    '& > *': {
      margin: theme.spacing(1),
    },
  },
  button: {
    marginTop: theme.spacing(2),
  },
}));

const Login: React.FC = () => {
  const classes = useStyles();
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const { error, isLoading } = useSelector(selectAuth);

  const navigate = useNavigate();
  const dispatch = useDispatch();

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    dispatch(login({ username, password }));
  };

  return localStorage.hasOwnProperty("token") ? <Navigate to="/" /> : (
    <Box display="flex" justifyContent="center" alignItems="center" minHeight="100vh">
      <Paper elevation={3} style={{ padding: '20px' }}>
        <form className={classes.form} onSubmit={handleSubmit}>
          <h2>Login</h2>
          <TextField
            id="username"
            label="Username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
          <br />
          <TextField
            id="password"
            label="Password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <br />
          {isLoading && (<LoadingSpinner />)}
          {error && (
            <Typography variant="body2" color="error">
              {error}
            </Typography>
          )}
          <Button variant="contained" color="primary" type="submit" className={classes.button}>
            Login
          </Button>
        </form>
      </Paper>
    </Box>
  );
};

export default Login;

// import { useState } from 'react';
// import { useNavigate } from 'react-router-dom';
// import { TextField, Button } from '@material-ui/core';
// import { useDispatch } from 'react-redux';
// import { login } from '../store/authSlice';
// import { useTypedSelector } from '../store';

// const Login: React.FC = () => {
// const [username, setUsername] = useState('');
// const [password, setPassword] = useState('');
// const auth = useTypedSelector(state => state.auth);
// const navigate = useNavigate();
// const dispatch = useDispatch();

// async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
//     e.preventDefault();
//     await dispatch(login({username, password}));
//     if (!auth.error) {
//         navigate('/');
//     }
// }

// return (
//     <div>
//         <form onSubmit={handleSubmit}>
//             <TextField
//                 id="username"
//                 label="Username"
//                 value={username}
//                 onChange={(e) => setUsername(e.target.value)}
//             />
//             <br />
//             <TextField
//                 id="password"
//                 label="Password"
//                 type="password"
//                 value={password}
//                 onChange={(e) => setPassword(e.target.value)}
//             />
//             <br />
//             <Button variant="contained" color="primary" type="submit">
//                 Login
//             </Button>
//         </form>
//         {auth.error && (
//             <p>{auth.error}</p>
//         )}
//     </div>
// );
