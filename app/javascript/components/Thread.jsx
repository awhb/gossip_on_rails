// Thread.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Post from './Post';

const Thread = ({ match }) => {
  const [thread, setThread] = useState({});
  
  useEffect(() => {
    const fetchData = async () => {
      const result = await axios.get(`/api/forums/${match.params.id}`);
      setThread(result.data);
    };
    fetchData();
  }, [match.params.id]);
  
  return (
    <div>
      <h1>{thread.name}</h1>
      <ul>
        {thread.posts.map(post => (
          <li key={post.id}>
            <Post post={post} />
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Thread;