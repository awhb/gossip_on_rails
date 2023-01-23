import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Posts from ;
import Recipe from "../components/Recipe"
import NewRecipe from "../components/NewRecipe";
import Login from "../pages/Login";

export default (
  <Router>
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/" element={<Home />} />
      <Route path="/posts" element={<Posts />} />
      <Route path="/posts/:id" element={<Recipe />} />
      <Route path="/posts/new" element={<NewRecipe />} />
      <Route path="/*" element={<Home />} />
    </Routes>
  </Router>
);