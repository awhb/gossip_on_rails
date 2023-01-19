import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Posts from "../components/Posts"
import Recipe from "../components/Recipe"
import NewRecipe from "../components/NewRecipe";

export default (
  <Router>
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/posts" element={<Posts />} />
      <Route path="/posts/:id" element={<Recipe />} />
      <Route path="/posts/new" element={<NewRecipe />} />
    </Routes>
  </Router>
);