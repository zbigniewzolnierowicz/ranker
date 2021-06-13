import '../../deps/phoenix_html'
import ReactDOM from 'react-dom'
import { App } from './App'
import { FC } from 'react'
import { Provider } from 'react-redux'
import { store } from './store'
import { ChakraProvider } from '@chakra-ui/react'

const AppWithWrappers: FC = () => {
    return (
        <Provider store={store}>
            <ChakraProvider>
                <App />
            </ChakraProvider>
        </Provider>
    )
}

ReactDOM.render(<AppWithWrappers />, document.getElementById('app'))

export {}