/*
 * Copyright 2019 Square Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import WorkflowUI


/// A `SplitScreenContainerScreen` displays two screens side by side with a separator in between.
public struct SplitScreenContainerScreen: Screen {

    /// The screen displayed to the left of the separator.
    public var leftScreen: AnyScreen

    /// The screen displayed to the right of the separator.
    public var rightScreen: AnyScreen

    /// The ratio of `leftScreen`'s width relative to that of `rightScreen`. Defaults to `.third`.
    public var ratio: Ratio
    
    /// The color of the `separatorView` displayed between `leftScreen`'s and `rightScreen`'s views.
    public var separatorColor: UIColor

    ///TODO Doc Comment
    public var axis: NSLayoutConstraint.Axis

    public init<LeftScreenType: Screen, RightScreenType: Screen>(
        leftScreen: LeftScreenType,
        rightScreen: RightScreenType,
        ratio: Ratio = .third,
        separatorColor: UIColor = .black,
        axis: NSLayoutConstraint.Axis = .vertical
    ) {
        self.leftScreen = AnyScreen(leftScreen)
        self.rightScreen = AnyScreen(rightScreen)
        self.ratio = ratio
        self.separatorColor = separatorColor
        self.axis = axis
    }

}


extension SplitScreenContainerScreen {

    public struct Ratio {

        public var value: CGFloat

        public init(_ value: CGFloat) {
            self.value = value
        }

        public static let quarter = Ratio(1.0 / 4.0)
        public static let third = Ratio(1.0 / 3.0)
        public static let half = Ratio(1.0 / 2.0)

    }

}
