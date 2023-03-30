const express = require('express');
app=express();

app.get('/',(req,resp)=>{
  resp.send('Welcome to Test server');
});

app.listen(3000,()=>{
  console.log('Listening on port:- 3000');
});
