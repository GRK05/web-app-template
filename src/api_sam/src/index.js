const express = require("express");
const app = express();
const port = 8080;

app.get("/api", (req, res) => {
  res.send("API Container! Perhaps version 0.0.1?");
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
