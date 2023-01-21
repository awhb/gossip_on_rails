import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from 'axios';

const Posts = () => {
    const navigate = useNavigate();
    const [posts, setPosts] = useState([]);
    useEffect(() => {

        axios.get("/api/v1/posts")
        .then(({ data }) => {
            setPosts(data)
        })
    });

    const allPosts = posts.map((post, id) => (
        <div key={id} className="col-md-6 col-lg-4">
          <div className="card mb-4">
            <div className="card-body">
              <h5 className="card-title">{post.title}</h5>
              <Link to={`/posts/${post.id}`} className="btn custom-button">
                View Thread
              </Link>
            </div>
          </div>
        </div>
      ));
      
      const noPost = (
        <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
          <h4>
            No threads yet. Why not <Link to="/posts/new">create one</Link>
          </h4>
        </div>
      );
    
      return (
        <>
          <section className="jumbotron jumbotron-fluid text-center">
            <div className="container py-5">
            </div>
          </section>
          <div className="py-5">
            <main className="container">
              <div className="text-end mb-3">
                <Link to="/posts/new" className="btn custom-button">
                  Create New Post
                </Link>
              </div>
              <div className="row">
                {posts.length > 0 ? allPosts : noPost}
              </div>
              <Link to="/" className="btn btn-link">
                Home
              </Link>
            </main>
          </div>
        </>
      );
};
  
  export default Posts;