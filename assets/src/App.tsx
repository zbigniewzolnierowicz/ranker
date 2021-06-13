import { ChakraProvider } from "@chakra-ui/react"
import { Provider } from "react-redux";
import { BrowserRouter as Router, Link, Route, Switch } from "react-router-dom"
import { Header } from "./components/Header"
import { About } from "./pages/About";
import { Home } from "./pages/Home";
import { Users } from "./pages/Users";
import { store } from "./store";

export const App = () => {
    return (
      <Provider store={store}>
        <ChakraProvider>
          <Router>
            <div>
              <Header />
              <Switch>
                <Route path="/about">
                  <About />
                </Route>
                <Route path="/users">
                  <Users />
                </Route>
                <Route path="/">
                  <Home />
                </Route>
              </Switch>
            </div>
          </Router>
        </ChakraProvider>
      </Provider>
      );
    
}