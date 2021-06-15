import { Property } from 'csstype'

type MediaQueryArrayReturner = (display: Property.Display) => Property.Display[]

const hiddenDisplayProperty: Property.Display = 'none'

export const hideInMobile: MediaQueryArrayReturner = display => [hiddenDisplayProperty, display]
export const showInMobile: MediaQueryArrayReturner = display => [display, hiddenDisplayProperty]
