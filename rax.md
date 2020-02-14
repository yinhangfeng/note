## Element

createElement 返回值
变量名为 element

## public component

Component
PureComponent ReactiveComponent(function component 的对称 public class) Root

Fragment 本身是一个 function component，在 instantiateComponent 会创建 CompositeComponent 的 internal instance
但 Fragment render 直接返回了 children，所以在 CompositeComponent 创建 RENDERED_COMPONENT 时 instantiateComponent 接收
到的可能是数组，导致返回的为 FragmentComponent internal instance
所以 FragmentComponent 并不对应 Fragment 组件本身，而对应其返回值
如果一个自定义 Component render 返回数组，返回值也会对应 FragmentComponent

## internal component

BaseComponent
NativeComponent CompositeComponent TextComponent FragmentComponent EmptyComponent

## internal instance

type: BaseComponent
instanceOf BaseComponent
内部变量名一般为 component

```
{
  __currentElement: Element;
  _parent: Container | NativeNode;
  __parentInstance: Instance;
  _context: any;
  _mountID: number;
  INSTANCE: Instance;
  __getPublicInstance: () => NativeNode;
  __getNativeNode: () => NativeNode;
  __mountComponent: (parent, parentInstance, context, nativeNodeMounter) => Instance;
  unmountComponent: (shouldNotRemoveChild) => void;

  __updateComponent: ((prevElement, nextElement, prevContext, nextContext)) => void;

  NativeComponent:
    NATIVE_NODE: NativeNode;
    __renderedChildren: {
      [key: string]: BaseComponent;
    };

  CompositeComponent:
  RENDERED_COMPONENT: BaseComponent;
}
```

## public instance

type: Instance
内部变量名一般为 instance

### public component instance (CompositeComponent 才有)

type: Component

```
{
  props;
  context;
  refs: {};
  updater: Updater;
  INTERNAL: BaseComponent;
  state;
}
```

### 非 CompositeComponent 与 CompositeComponent 对称的 instance (是一个简单对象)
type: PlainObject

```
{
  INTERNAL: BaseComponent,

  NativeComponent:
    type,
    props,
}
```

## NativeNode

driver.createElement 返回值
driver-dom 为 dom node
对于 FragmentComponent 为 NativeNode[]
对于 EmptyComponent 为 driver.createEmpty

```
{
  _r: Instance; //(_r 为 Instance 的 key)
}
```

## Container

一般 container 就是一个 NativeNode
render 的时候如果不给则会调用 driver.createBody 创建
