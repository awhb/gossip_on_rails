import React, { useState } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { TextField, Button } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import { Box, Paper, Typography } from '@material-ui/core';

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

const Signup: React.FC = () => {
  const classes = useStyles();
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');

  interface JWT {
    token: string;
    username: string;
  }

  const navigate = useNavigate();

  async function handleSubmit (e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setIsLoading(true);
    postRequest('api/v1/users', {'username': username, 'password': password})
    .then((value: object) => {
      
      const jwt = value as JWT
      localStorage.setItem('token', jwt.token)
      localStorage.setItem('username', jwt.username)
      setIsLoading(false);
      navigate("/");
    })
    .catch((error: any) => {
      setIsLoading(false);
      setError('Username already exists. Please use a different one.');
    });
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

export default Signup;

