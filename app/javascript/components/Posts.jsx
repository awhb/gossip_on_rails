import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Posts = () => {
    const navigate = useNavigate();
    const [posts, setPosts] = useState([]);
    useEffect(() => {
        const url = "/api/v1/posts/index";
        fetch(url)
          .then((res) => {
            if (res.ok) {
              return res.json();
            }
            throw new Error("Network response was not ok.");
          })
          .then((res) => setPosts(res))
          .catch(() => navigate("/"));
    }, []);

    const allPosts = posts.map((post, index) => (
        <div key={index} className="col-md-6 col-lg-4">
          <div className="card mb-4">
            <div className="card-body">
              <h5 className="card-title">{post.title}</h5>
              <Link to={`/post/${post.id}`} className="btn custom-button">
                View Thread
              </Link>
            </div>
          </div>
        </div>
      ));
      
      const noPost = (
        <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
          <h4>
            No threads yet. Why not <Link to="/new_post">create one</Link>
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
                <Link to="/post" className="btn custom-button">
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