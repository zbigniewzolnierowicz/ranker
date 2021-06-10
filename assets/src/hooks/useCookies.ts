import { useMemo } from "react"
import Cookies from "universal-cookie/es6"

export const useCookies = () => {
    const cookiesInstance = useMemo(() => new Cookies(), [])
    return cookiesInstance
}