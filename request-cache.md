## React 一个请求先返回缓存之后刷新数据的解决方案

* fetch(opts, ({ data: any, isCache: bool }) => void): Promise<data>
  
```javascript
this.setState({
  isLoading: true,
});
try {
  await fetch(opts, ({ data, isCache}) => {
    this.setState({
      data,
      isLoading: !isCache,
    });
  });
} catch (error) {
  this.setState({
    error,
    isLoading: false,
  });
}
```

* fetch(opts): [{ data: any, isCache: bool }] (for await)

```javascript
this.setState({
  isLoading: true,
});
try {
  for await ({ data, isCache } of fetch()) {
    this.setState({
      data,
      isLoading: !isCache,
    });
  }
} catch (error) {
  this.setState({
    error,
    isLoading: false,
  });
}
```

* fetch(opts): Promise<{data, next: Promise<data>}>

```javascript
this.setState({
  isLoading: true,
});
try {
  const { data, next } await fetch();
  this.setState({
    data,
  });
  const newData = await next;
  this.setState({
    data: newData,
    isLoading: false,
  });
} catch (error) {
  this.setState({
    error,
    isLoading: false,
  });
}
```

* generator

##

```javascript
{
  cacheData,
}
```
