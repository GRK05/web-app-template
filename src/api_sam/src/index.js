const express = require("express");
const app = express();
const port = 8080;

app.get("/api", (req, res) => {
  res.send("API Container!");
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
