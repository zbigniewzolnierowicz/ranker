import { Property } from 'csstype'

export const hideInMobile = (display: Property.Display) => ['none', display]
export const showInMobile = (display: Property.Display) => [display, 'none']