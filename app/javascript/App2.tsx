import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "./components/Home";
import Posts from "./components/Posts";
import Recipe from "./components/Recipe"
import NewRecipe from "./components/NewRecipe";
import Login from "./pages/Login";
import MenuAppBar from "./components/MenuAppBar";

function App() {
  return (
    <div className="App">
      <Router>
        <header className="App-header">
          <MenuAppBar />
        </header>
        <main>
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route path="/" element={<Home />} />
            <Route path="/posts" element={<Posts />} />
            <Route path="/posts/:id" element={<Recipe />} />
            <Route path="/posts/new" element={<NewRecipe />} />
            <Route path="/*" element={<Home />} />
          </Routes>
        </main>
      </Router>
    </div>
  );
}

export default App;