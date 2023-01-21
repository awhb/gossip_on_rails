// ForumList.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';

const Home = () => {
  const [posts, setPosts] = useState([]);
  
  useEffect(() => {
    const fetchData = async () => {
      const result = await axios.get('/api/forums');
      setForums(result.data);
    };
    fetchData();
  }, []);
  
  return (
    <div>
      <h1>Forums</h1>
      <ul>
        {forums.map(forum => (
          <li key={forum.id}>
            <Link to={`/posts/${forum.id}`}>{post.name}</Link>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default ForumList;
