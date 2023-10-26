open ReactDOM.Client

%%raw(`
  import "../../styles/styles.build.css";
`)

@val @scope("document")
external getElementById: string => Dom.element = "getElementById"

let root = createRoot(getElementById("root"))->Root.render(
  <React.StrictMode>
    <WebApp />
  </React.StrictMode>,
)
