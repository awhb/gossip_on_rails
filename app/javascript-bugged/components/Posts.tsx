import React, { useState, useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../hooks/redux-hooks";
import { fetchPosts } from "../store/post-actions";
import { makeStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
  },
  paper: {
    padding: theme.spacing(2),
    textAlign: 'center',
    color: theme.palette.text.secondary,
  },
}));

const Posts: React.FC = () => {
  const dispatch = useAppDispatch();
  const allPosts = useAppSelector((state) => state.posts.all_posts);
  const classes = useStyles();
  const [page, setPage] = useState(1);
  const [limit] = useState(10);

  useEffect(() => {
    dispatch(fetchPosts());
  });

  return (
    <div className={classes.root}>
      <Grid container spacing={3}>
        {allPosts.map((post) => (
          <Grid item xs={12} sm={6} md={4} key={post.id}>
            <Paper className={classes.paper}>
              <Typography variant="h6">{post.title}</Typography>
              <Typography>{post.creator}</Typography>
              <Typography>{post.created_at.toDateString()}</Typography>
            </Paper>
          </Grid>
        ))}
      </Grid>
    </div>
  );
};

export default Posts;